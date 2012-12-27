class BeveragesController < ApplicationController
  # GET /beverages
  # GET /beverages.json
  def index
    @filters = session[:beverage_filters] || []

    if params[:filter].present?
      @filters.reject!{|f| f[:filter] == params[:filter]}
      if params[:delta] == "1"
        @filters |= [{filter: params[:filter], value: params[:value]}]
      end
      session[:beverage_filters] = @filters
    end

    criteria = Beverage.scoped

    @filters.each do |filter|
      case filter[:filter]
        when "country"
          country = Country.find_by_name(filter[:value])
          regions = country.regions
          criteria = criteria.where(region_id: regions.map(&:id))
      end
    end

    if params[:type].present?
      criteria = criteria.where(type: params[:type])
      @type = params[:type]
    end

    @beverage_brands = criteria.where("brand_id IS NOT NULL").group_by(&:brand)
    #raise @beverage_brands.to_yaml

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @beverage_brands }
    end
  end

  # GET /beverages/1
  # GET /beverages/1.json
  def show
    @beverage = Beverage.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @beverage }
    end
  end

  # GET /beverages/new
  # GET /beverages/new.json
  def new
    @beverage = Beverage.new

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

    respond_to do |format|
      if @beverage.save
        format.html { redirect_to @beverage, notice: 'Beverage was successfully created.' }
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
        format.html { redirect_to @beverage, notice: 'Beverage was successfully updated.' }
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
      format.html { redirect_to beverages_url }
      format.json { head :no_content }
    end
  end
end
