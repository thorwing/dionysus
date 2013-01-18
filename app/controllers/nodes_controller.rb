class NodesController < ApplicationController

  def lock
    if Node.where(id: params[:id]).exists?
      current_user.locked_node_ids = current_user.locked_node_ids | [params[:id]]
      current_user.save
    end

    redirect_to topics_path
  end

  def unlock
    if Node.where(id: params[:id]).exists?
      current_user.locked_node_ids = current_user.locked_node_ids - [params[:id]]
      current_user.save
    end

    redirect_to topics_path
  end
end