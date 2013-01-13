class FollowsController < ApplicationController
  before_filter :preload

  def follow
    unless current_user.following?(@followable)
      current_user.follow(@followable)

      #FeedsManager.new(current_user, 'follow', @followable).generate_for(current_user)
      #
      #NotificationsManager.new(current_user, 'follow', @followable).generate_for(@followable) if @followable.is_a? User
    end

    respond_to do |format|
      format.html { redirect_to :back, notice: t("notices.follow_successful") }
      format.js
    end
  end

  def unfollow
    if current_user.following?(@followable)
      current_user.stop_following(@followable)
    end

    respond_to do |format|
      format.html { redirect_to :back, notice: t("notices.follow_cancel") }
      format.js
    end
  end

  private
  def preload
    begin
      @followable = params[:item_type].singularize.classify.constantize.find(params[:item_id])
    rescue
      not_found
    end
  end
end