class HomeController < ApplicationController
  def index
    @hot_articles = Article.limit(5)
    @hot_lists = List.limit(3)
  end
end
