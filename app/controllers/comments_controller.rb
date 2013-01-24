class CommentsController < ApplicationController
  before_filter :preload

  def index

  end

  def create
    @over_limit = Cooler.rapid_commenter?(current_user)

    unless @over_limit
      @comment = Comment.create(params[:comment]) do |comment|
        comment.author = current_user
      end
      if @comment.parent
        @parent = @comment.parent
        receipt = NotificationsManager.notify(@comment.parent.author, t("notifications.comment_comment", who: current_user.nick), view_context.link_to(t("notifications.check_out"), @comment.commentable), current_user)
      else
        case @comment.commentable_type
          when "Review"
            receipt = NotificationsManager.notify(@comment.commentable.author, t("notifications.comment_review", who: current_user.nick), view_context.link_to(@comment.commentable.title, @comment.commentable), current_user)
        end
      end
    end

    respond_to do |format|
      format.html {redirect_to :back, notice: t('notices.comment_created')}
      format.js {render :content_type => 'text/javascript'}
    end
  end

  def destroy
    @comment.delete

    respond_to do |format|
        format.html {redirect_to :back}
        format.js {render :content_type => 'text/javascript'}
    end
  end

  protected

  def preload
    begin
      @comment = Comment.find(params[:id]) if params[:id]
      @commentable = params[:commentable_type].singularize.classify.constantize.find(params[:commentable_id]) if params[:commentable_type].present? && params[:commentable_id].present?
    rescue
      not_found
    end
  end

end