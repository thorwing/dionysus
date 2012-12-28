class WishesController < ApplicationController
  before_filter :preload
  before_filter(:except => [:index, :show]) { |c| c.require_permission :normal_user }
  before_filter(:only => [:edit, :update]) {|c| c.the_author_himself(@wish, false, true)}
  before_filter(:only => [:delete]) {|c| c.the_author_himself(@wish, false, true)}

  def new
    @wish = Wish.new
    @wish.beverage = Beverage.find(params[:beverage_id])
  end

  def create
    @wish = Wish.new(params[:wish])
    @wish.author = current_user

    respond_to do |format|
      if @wish.save
        format.html { redirect_to @wish.beverage, notice: 'Wish was successfully created.' }
        format.json { render json: @wish, status: :created, location: @wish }
      else
        format.html { render action: "new" }
        format.json { render json: @wish.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def preload
    begin
      @wish = Wish.find(params[:id]) if params[:id].present?
    rescue
      not_found
    end
  end

end
