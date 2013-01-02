class ArticlesController < ApplicationController
  before_filter :preload

  # GET /articles
  # GET /articles.json
  def index
    @articles = Article.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @articles }
    end
  end

  # GET /articles/1
  # GET /articles/1.json
  def show

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @article }
    end
  end

  private

  def preload
    begin
      @article = Article.find(params[:id]) if params[:id].present?
    rescue
      not_found
    end
  end
end
