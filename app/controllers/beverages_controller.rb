class BeveragesController < ApplicationController
  load_and_authorize_resource

  # GET /beverages
  # GET /beverages.json
  def index
    criteria = Beverage.scoped

    if params[:type].present?
      criteria = criteria.where(type: params[:type])
      @type = params[:type]
    end

    @filters = params[:filter] || []
    @filters.each do |filter, values|
      case filter
        when "vintage"
          criteria = criteria.where(vintage: values)
        when "grape"
          criteria = criteria.tagged_with(values, on: :grape)
        when "country"
          country = Country.find_by_name(filter[:value])
          criteria = criteria.where(region_id: country.regions.map(&:id)) if country
        else
          criteria = criteria.where(filter.to_sym => values)
      end
    end

    @beverage_brands = criteria.where("brand_id IS NOT NULL").group_by(&:brand)
    #raise @beverage_brands.to_yaml

    @regions = Region.of(@type)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @beverage_brands }
    end
  end

  # GET /beverages/1
  # GET /beverages/1.json
  def show
    @beverage = Beverage.find(params[:id])

    @rating_hash = {}
    5.downto(1).each do |rating|
      @rating_hash[rating] = 0
    end
    @beverage.wishes.each do |wish|
      @rating_hash[wish.rating] += 1
    end
    wishes_size = @beverage.wishes.size
    @rating_hash.each do |rating, count|
      @rating_hash[rating] = wishes_size == 0 ? 0 : (count.to_f / wishes_size.to_f * 100).to_i
    end

    @rating = @beverage.rating

    other_wishes = Wish.where("id != ?", @beverage.id).where(user_id: @beverage.wishes.map(&:user_id))
    @other_beverages = Beverage.where(id: other_wishes.map(&:beverage_id)).limit(10)

    @sellers = @beverage.deals.limit(4).map(&:seller)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @beverage }
    end
  end

  # GET /beverages/new
  # GET /beverages/new.json
  def new
    @beverage = Beverage.new(type: params[:type])

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @beverage }
    end
  end

  # GET /beverages/1/edit
  def edit
    @beverage = Beverage.find(params[:id])
  end

  # POST /beverages
  # POST /beverages.json
  def create
    @beverage = Beverage.new(params[:beverage])
    @beverage.author = current_user

    respond_to do |format|
      if @beverage.save
        FeedsManager.new(current_user, 'create', @beverage).generate
        format.html { redirect_to @beverage, notice: t("beverages.beverage_created")}
        format.json { render json: @beverage, status: :created, location: @beverage }
      else
        format.html { render action: "new" }
        format.json { render json: @beverage.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /beverages/1
  # PUT /beverages/1.json
  def update
    @beverage = Beverage.find(params[:id])

    respond_to do |format|
      if @beverage.update_attributes(params[:beverage])
        #monkey patch for changing type
        type = params[params[:type].downcase.to_sym][:type]
        if(type .present?)
          @beverage.type = type
          @beverage.save
        end
        format.html { redirect_to @beverage, notice: t("beverages.beverage_updated")}
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @beverage.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /beverages/1
  # DELETE /beverages/1.json
  def destroy
    @beverage = Beverage.find(params[:id])
    @beverage.destroy

    respond_to do |format|
      format.html { redirect_to root_path }
      format.json { head :no_content }
    end
  end
end
