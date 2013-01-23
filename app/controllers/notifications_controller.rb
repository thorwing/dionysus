class NotificationsController < ApplicationController
  def index
      @notifications = current_user.mailbox.notifications.page(params[:page]).per(9)
  end

  def count
    @unread_notifications_count = current_user.mailbox.notifications.size
    @new_messages_count = current_user.mailbox.conversations(mailbox_type: "inbox", read: false).size
    @sum = @unread_notifications_count + @new_messages_count

    respond_to do |format|
      format.js
    end

  end

end
