class PackagesController < ApplicationController
  def new
    beverage = Beverage.find(params[:beverage_id])
    @package = Package.new(beverage_id: params[:beverage_id])
    @included_lists = beverage.lists.where(author_id: current_user.id)
    @to_include_lists = beverage.lists.where("author_id != ?", current_user.id)
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
