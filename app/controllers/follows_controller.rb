class FollowsController < ApplicationController
  before_filter :preload

  def follow
    unless current_user.following?(@followable)
      current_user.follow(@followable)
      FeedsManager.new(current_user, 'follow', @followable).generate
      receipt = NotificationsManager.notify(@followable, t("notifications.follow_you", who: current_user.nick), view_context.link_to(current_user.nick, current_user), current_user)
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