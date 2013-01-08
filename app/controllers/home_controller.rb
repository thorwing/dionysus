class HomeController < ApplicationController
  def index
    @hot_articles = Article.limit(2)
    @hot_reviews = Review.limit(2)
    @hot_lists = List.limit(3)
  end
end
