class HomeController < ApplicationController
  def index
    @hot_articles = Article.limit(2)
    @hot_reviews = Review.limit(2)
  end
end
