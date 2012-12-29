class ApplicationController < ActionController::Base
  protect_from_forgery
  helper :application, :layout, :external_link
  include ApplicationHelper
  helper_method :current_user, :the_author_himself

  def current_user
    if @current_user
      @current_user
    elsif cookies[:auth_token]
      @current_user = User.of_auth_token(cookies[:auth_token])
      if @current_user
        @current_user.save
      end
      @current_user
    else
      nil
    end
    #@current_user ||= User.of_auth_token(cookies[:auth_token]) if cookies[:auth_token]
  end

  # redirect somewhere that will eventually return back to here
  def redirect_away(*params)
    session[:original_uri] = request.fullpath
    redirect_to(*params)
  end

  # returns the person to either the original url from a redirect_away or to a default url
  def redirect_back(*params)
    uri = session[:original_uri]
    session[:original_uri] = nil
    if uri
      redirect_to uri
    else
      redirect_to(*params)
    end
  end

  def require_permission(permission)
    if current_user && current_user.has_permission?(permission)
      true
    else
      if current_user
        redirect_to :back, :alert => t("alerts.need_permission_not_logged", :permission => t("roles.#{permission.to_s}") )
      else
        redirect_away :login, :alert => t("alerts.need_permission_logged", :permission => permission)
      end
      false
    end
  end

  def the_author_himself(item, or_admin = false, is_redirect = false)
    has_permission = false

    if (or_admin == true && current_user_has_permission?(:admin))
      has_permission = true
    elsif current_user_has_permission?(:normal_user)
      begin
        has_permission = (item && item.respond_to?(:author_id)) ? (item.author_id == current_user.id) : false
      rescue
      end
    end

    if !has_permission && is_redirect
      redirect_to :back, :alert => t("alerts.only_author_self")
    end

    has_permission
  end
end
