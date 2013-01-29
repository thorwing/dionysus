class PackagesController < ApplicationController
  def new
    @package = Package.new(beverage_id: params[:beverage_id])
  end

  def create
    @package = Package.new(params[:package])

    respond_to do |format|
      if @package.save
        format.html { redirect_to @package.list, notice: t("lists.list_added")}
      else
        format.html { render action: "new" }
      end
    end
  end

  def destroy
    @package = Package.find(params[:id])
    @package.destroy

    respond_to do |format|
      format.html { redirect_to @package.list }
      format.json { head :no_content }
    end
  end
end
