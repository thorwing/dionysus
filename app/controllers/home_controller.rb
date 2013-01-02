class HomeController < ApplicationController
  def index
    @hot_articles = Article.all
  end
end
