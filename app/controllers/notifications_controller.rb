class NotificationsController < ApplicationController
  def index
    @notifications = current_user.mailbox.notifications.page(params[:page]).per(9)
  end
end
