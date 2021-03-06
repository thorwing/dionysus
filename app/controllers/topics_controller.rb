class TopicsController < ApplicationController
  before_filter :preload

  # GET /topics
  # GET /topics.json
  def index
    criteria = Topic.scoped
    locked_node_ids = []
    if current_user
      locked_node_ids = current_user.locked_node_ids

      unless locked_node_ids.empty?
        @locked_nodes = Node.where(id: locked_node_ids)
        unless params[:all].present? && params[:all] == "true"
          criteria = criteria.where(node_id: locked_node_ids)
        end
      end
    end

    @locked_nodes ||= []
    @unlocked_nodes = locked_node_ids.empty? ? Node.all : Node.where("id NOT IN (?)", locked_node_ids)
    @topics = criteria.order("last_active_mark DESC").page(params[:page]).per(20)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @topics }
    end
  end

  # GET /topics/1
  # GET /topics/1.json
  def show
    @replies = Reply.where(topic_id: @topic.id)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @topic }
    end
  end

  # GET /topics/new
  # GET /topics/new.json
  def new
    @topic = Topic.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @topic }
    end
  end

  # GET /topics/1/edit
  def edit
    @topic = Topic.find(params[:id])
  end

  # POST /topics
  # POST /topics.json
  def create
    @topic = Topic.new(params[:topic])
    @topic.author = current_user

    respond_to do |format|
      if @topic.save
        FeedsManager.new(current_user, 'create', @topic).generate
        format.html { redirect_to @topic, notice: t("topics.topic_created")}
        format.json { render json: @topic, status: :created, location: @topic }
      else
        format.html { render action: "new" }
        format.json { render json: @topic.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /topics/1
  # PUT /topics/1.json
  def update

    respond_to do |format|
      if @topic.update_attributes(params[:topic])
        format.html { redirect_to @topic, notice: t("topics.topic_updated") }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @topic.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /topics/1
  # DELETE /topics/1.json
  def destroy
    @topic.destroy

    respond_to do |format|
      format.html { redirect_to topics_url }
      format.json { head :no_content }
    end
  end

  private

  def preload
    begin
      @topic = Topic.find(params[:id]) if params[:id].present?
    rescue
      not_found
    end
  end

end
