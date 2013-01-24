class ListsController < ApplicationController
  before_filter :preload

  # GET /lists
  # GET /lists.json
  def index
    @lists = List.page(params[:page]).per(20)
    @new_lists = List.order("created_at DESC").limit(5)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @lists }
    end
  end

  # GET /lists/1
  # GET /lists/1.json
  def show

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @list }
    end
  end


  def new
    @list = List.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @list }
    end
  end

  def edit

  end

  def create
    @list = List.new(params[:list])
    @list.author = current_user

    respond_to do |format|
      if @list.save
        FeedsManager.new(current_user, 'create', @list).generate
        format.html { redirect_to @list, notice: t("lists.list_created") }
        format.json { render json: @list, status: :created, location: @list }
      else
        format.html { render action: "new" }
        format.json { render json: @list.errors, status: :unprocessable_entity }
      end
    end
  end

  def update

    respond_to do |format|
      if @list.update_attributes(params[:list])
        format.html { redirect_to @list, notice: t("lists.list_updated") }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @list.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @list.destroy

    respond_to do |format|
      format.html { redirect_to lists_url }
      format.json { head :no_content }
    end
  end

  private

  def preload
    begin
      @list = List.find(params[:id]) if params[:id].present?
    rescue
      not_found
    end
  end
end
