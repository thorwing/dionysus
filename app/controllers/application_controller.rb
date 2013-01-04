class ApplicationController < ActionController::Base
  protect_from_forgery

  helper :application, :layout, :external_link
  #include ApplicationHelper

end
