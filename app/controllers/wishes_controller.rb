class WishesController < ApplicationController
  before_filter :preload

  def new
    @wish = Wish.new(beverage_id: params[:beverage_id], accomplished: params[:accomplished] || false)
  end

  def create
    @wish = Wish.new(params[:wish])
    @wish.user = current_user

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

  def destroy
    @wish.destroy

    respond_to do |format|
      format.html { redirect_to :back }
      format.json { head :no_content }
    end
  end

  def like
    if current_user.up_voted?(@item)
      current_user.unvote(@item)

      @voted = false
    else
      if current_user.down_voted?(@item)
        current_user.unvote(@item)
      end

      @voted = true
    end

    respond_to do |format|
      format.html {redirect_to :back }
      format.xml {head :ok}
      format.js {render "votes/like", :content_type => 'text/javascript'}
    end
  end

  def hate
    if current_user.down_voted?(@item)
      current_user.unvote(@item)
      @voted = false
    else
      if current_user.up_voted?(@item)
        #only to erase the awarded point
        current_user.unvote(@item)
      end

      current_user.down_vote(@item)
      @voted = true
    end

    respond_to do |format|
      format.html {redirect_to :back }
      format.xml {head :ok}
      format.js {render "votes/hate", :content_type => 'text/javascript'}
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
