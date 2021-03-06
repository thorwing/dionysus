class ArticlesController < ApplicationController
  before_filter :preload

  # GET /articles
  # GET /articles.json
  def index
    @articles = Article.page(params[:page]).per(10)
    @hot_articles = Article.order("view_count DESC").limit(5)

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


  def new
    @article = Article.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @article }
    end
  end

  def edit

  end

  def create
    @article = Article.new(params[:article])
    @article.author = current_user

    respond_to do |format|
      if @article.save
        format.html { redirect_to @article, notice: t("articles.article_created") }
        format.json { render json: @article, status: :created, location: @article }
      else
        format.html { render action: "new" }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  def update

    respond_to do |format|
      if @article.update_attributes(params[:article])
        format.html { redirect_to @article, notice: t("articles.article_updated") }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @article.destroy

    respond_to do |format|
      format.html { redirect_to articles_url }
      format.json { head :no_content }
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
