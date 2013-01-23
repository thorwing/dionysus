class WishesController < ApplicationController
  before_filter :preload

  def new
    @wish = Wish.new(beverage_id: params[:beverage_id], accomplished: params[:accomplished] || false)
  end

  def create
    @wish = Wish.new(params[:wish])
    @wish.user = current_user

    respond_to do |format|
      if @wish.save
        format.html { redirect_to @wish.beverage, notice: t("wishes.wish_created") }
        format.json { render json: @wish, status: :created, location: @wish }
      else
        format.html { render action: "new" }
        format.json { render json: @wish.errors, status: :unprocessable_entity }
      end
    end
  end

  def update

    respond_to do |format|
      if @wish.update_attributes(params[:wish])
        format.html { redirect_to @wish.beverage }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @wish.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @wish.destroy

    respond_to do |format|
      format.html { redirect_to :back }
      format.json { head :no_content }
    end
  end


  private

  def preload
    begin
      @wish = Wish.find(params[:id]) if params[:id].present?
    rescue
      not_found
    end
  end

end
