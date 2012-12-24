class ApplicationController < ActionController::Base
  protect_from_forgery
  helper :external_link, :layout
  helper_method :current_user

  def current_user
    if @current_user
      @current_user
    elsif cookies[:auth_token]
      @current_user = User.of_auth_token(cookies[:auth_token])
      if @current_user
        @current_user.last_shown = Time.now
        @current_user.save
      end
      @current_user
    else
      nil
    end
    #@current_user ||= User.of_auth_token(cookies[:auth_token]) if cookies[:auth_token]
  end
end
