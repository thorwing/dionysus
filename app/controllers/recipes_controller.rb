class RecipesController < ApplicationController
  before_filter :preload

  # GET /recipes
  # GET /recipes.json
  def index
    @recipes = Recipe.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @recipes }
    end
  end

  # GET /recipes/1
  # GET /recipes/1.json
  def show
    @other_recipes = @recipe.cocktail.recipes.where("id != ?", @recipe.id)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @recipe }
    end
  end

  # GET /recipes/new
  # GET /recipes/new.json
  def new
    session[:recipe_stage] = nil
    session[:recipe_params] = nil
    @recipe = Recipe.new
    @recipe.current_stage = @recipe.stages.first
    if params[:cocktail_id].present?
      cocktail = Cocktail.find(params[:cocktail_id])
      @recipe.cocktail = cocktail
      @recipe.name = cocktail.name
      1.upto(3).each do
        @recipe.ingredients.build
      end
      @recipe.next_stage
      session[:recipe_stage] = @recipe.current_stage
    end

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @recipe }
    end
  end

  # GET /recipes/1/edit
  def edit

  end

  # POST /recipes
  # POST /recipes.json
  def create
    saved = false
    notice = nil
    session[:recipe_params] ||= {}
    session[:recipe_params].deep_merge!(params[:recipe]) if params[:recipe]
    @recipe = Recipe.new(session[:recipe_params]) do |r|
      r.current_stage = session[:recipe_stage]
    end

    if @recipe.valid?
      if params[:back_button]
        @recipe.previous_stage
      elsif @recipe.last_stage?
        @recipe.author = current_user
        @recipe.cocktail = Cocktail.find_or_create_by_name(@recipe.name) unless @recipe.cocktail
        saved = @recipe.save
      else
        @recipe.next_stage
      end

      if @recipe.current_stage == "detail"
        @similar_recipes = Recipe.text_search(@recipe.name.strip)

        1.upto(3).each do
          @recipe.ingredients.build
        end
      end

      session[:recipe_stage] = @recipe.current_stage

    end

    if saved
      FeedsManager.new(current_user, 'create', @recipe).generate
      session[:recipe_stage] =  session[:recipe_params] =  nil
      redirect_to url_for(contriller: "recipes", action: "show", id: @recipe.id, newly_created: true), notice: t("recipes.recipe_created")
    else
      render "new", notice: notice
    end
  end

  # PUT /recipes/1
  # PUT /recipes/1.json
  def update

    respond_to do |format|
      if @recipe.update_attributes(params[:recipe])
        format.html { redirect_to @recipe, notice: t("recipes.recipe_updated") }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /recipes/1
  # DELETE /recipes/1.json
  def destroy
    @recipe.destroy

    respond_to do |format|
      format.html { redirect_to recipes_url }
      format.json { head :no_content }
    end
  end

  private

  def preload
    begin
      @recipe = Recipe.find(params[:id]) if params[:id].present?
    rescue
      not_found
    end
  end
end
