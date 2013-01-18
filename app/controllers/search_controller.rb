class SearchController < ApplicationController
  def index
    @beverages = Beverage.text_search(params[:query]).limit(30) if params[:query].present?
  end
end
