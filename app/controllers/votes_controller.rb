class VotesController < ApplicationController
  before_filter :pre_load

  def up
    if current_user.up_voted?(@item)
      current_user.unvote(@item)

      @voted = false
    else
      if current_user.down_voted?(@item)
        current_user.unvote(@item)
      end

      current_user.up_vote(@item)
      @voted = true
    end

    respond_to do |format|
      format.html {redirect_to :back }
      format.js {render "votes/up", :content_type => 'text/javascript'}
    end
  end

  def down
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
      format.js {render "votes/down", :content_type => 'text/javascript'}
    end
  end

  private

  def pre_load
    begin
      @item = find_item(params[:item_type], params[:item_id])
    rescue
      not_found
    end
  end
end
