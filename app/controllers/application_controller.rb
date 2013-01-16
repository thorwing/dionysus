class ApplicationController < ActionController::Base
  protect_from_forgery

  helper :application, :layout, :external_link
  #include ApplicationHelper

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end

  def find_item(type, id)
    begin
      item = type.singularize.classify.constantize.find(id)
    rescue
      not_found
    end
  end

  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end
end
