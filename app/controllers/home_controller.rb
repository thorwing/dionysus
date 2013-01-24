class HomeController < ApplicationController
  def index
    @new_articles = Article.order("created_at DESC").limit(10)
    @hot_lists = List.limit(10)
    @hot_beverages = Beverage.limit(10)
  end
end
