class UsersController < ApplicationController
  # GET /users
  # GET /users.json
  def index
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])

    if @user.merchant?
      @deals = @user.deals
    else
      @want_drinks = @user.wishes.want
      @done_drinks = @user.wishes.done
    end

    @reviews = @user.reviews.order("created_at DESC").limit(3)
    @lists = @user.lists.order("created_at DESC").limit(3)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

  def search
    @users = User.text_search(params[:q]).where('id != ?', current_user.id)

    respond_to do |format|
      format.json { render json: @users.map { |u| {:id => u.id.to_s, :name => u.nick} } }
    end
  end

  def activites
    feeds_criteria = ActivityFeed.scoped

    user_ids = current_user.follows_by_type('User').map(&:followable_id) | [current_user.id]
    feeds_criteria = feeds_criteria.where("user_id in (:p)", p: user_ids)

    @feeds = feeds_criteria.order('created_at DESC').page(params[:page]).per(30)
  end
end
