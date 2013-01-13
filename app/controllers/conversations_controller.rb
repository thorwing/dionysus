class ConversationsController < ApplicationController
  before_filter :get_mailbox, :get_box
  before_filter :check_current_subject_in_conversation, :only => [:show, :update, :destroy]

  def index
    @mailbox = current_user.mailbox

    if @box.eql? "inbox"
      @conversations = @mailbox.inbox.page(params[:page]).per(9)
    elsif @box.eql? "sentbox"
      @conversations = @mailbox.sentbox.page(params[:page]).per(9)
    else
      @conversations = @mailbox.trash.page(params[:page]).per(9)
    end
  end

  def show
    if @box.eql? 'trash'
      @receipts = @mailbox.receipts_for(@conversation).trash
    else
      @receipts = @mailbox.receipts_for(@conversation).not_trash
    end
    render :action => :show
    @receipts.mark_as_read
  end

  def new

  end

  def edit

  end

  def create

  end

  def update
    if params[:untrash].present?
    @conversation.untrash(current_user)
    end

    if params[:reply_all].present?
      last_receipt = @mailbox.receipts_for(@conversation).last
      @receipt = current_user.reply_to_all(last_receipt, params[:body])
    end

    if @box.eql? 'trash'
      @receipts = @mailbox.receipts_for(@conversation).trash
    else
      @receipts = @mailbox.receipts_for(@conversation).not_trash
    end
    redirect_to :action => :show
    @receipts.mark_as_read

  end

  def destroy
    @conversation.move_to_trash(current_user)

    respond_to do |format|
      format.html { redirect_to conversations_path(box: :trash) }
    end
  end

  private

  def get_mailbox
    @mailbox = current_user.mailbox
  end

  def get_box
    if params[:box].blank? or !["inbox","sentbox","trash"].include?params[:box]
      @box = "inbox"
    return
    end
    @box = params[:box]
  end

  def check_current_subject_in_conversation
    @conversation = Conversation.find_by_id(params[:id])

    if @conversation.nil? or !@conversation.is_participant?(current_user)
      redirect_to conversations_path(:box => @box)
    return
    end
  end

end