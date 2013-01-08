class PackagesController < ApplicationController
  def new
    @package = Package.new(beverage_id: params[:beverage_id])
  end

  def create
    @package = Package.new(params[:package])

    respond_to do |format|
      if @package.save
        format.html { redirect_to @package.list, notice: 'Article was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end
end
