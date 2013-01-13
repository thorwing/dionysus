class MessagesController < ApplicationController
  #before_filter :get_mailbox, :get_box, :get_actor
  def index
    redirect_to conversations_path(:box => @box)
  end

  # GET /messages/1
  # GET /messages/1.xml
  def show
    if @message = Message.find_by_id(params[:id]) and @conversation = @message.conversation
      if @conversation.is_participant?(current_user)
        redirect_to conversation_path(@conversation, :box => @box, :anchor => "message_" + @message.id.to_s)
      return
      end
    end
    redirect_to conversations_path(:box => @box)
  end

  # GET /messages/new
  # GET /messages/new.xml
  def new
    if params[:receiver_id].present?
      @recipient = User.find(params[:receiver_id])
      return if @recipient.nil?
      @recipient = nil if @recipient == current_user
    end
  end

  # GET /messages/1/edit
  def edit

  end

  # POST /messages
  # POST /messages.xml
  def create
    @recipients = Array.new
    if params[:_recipients].present?
      params[:_recipients].split(",").each do |recp_id|
        recp = User.find_by_id(recp_id)
        next if recp.nil?
        @recipients << recp
      end
    end
    @receipt = current_user.send_message(@recipients, params[:body], params[:subject])
    if (@receipt.errors.blank?)
      @conversation = @receipt.conversation
      flash[:notice]= t('mailboxer.sent')
      redirect_to conversation_path(@conversation, :box => :sentbox)
    else
      render :action => :new
    end
  end

  # PUT /messages/1
  # PUT /messages/1.xml
  def update

  end

  # DELETE /messages/1
  # DELETE /messages/1.xml
  def destroy

  end

  private

  def get_box
    if params[:box].blank? or !["inbox","sentbox","trash"].include? params[:box]
      @box = "inbox"
      return
    end
    @box = params[:box]
  end

end