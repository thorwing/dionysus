class SessionsController < ApplicationController
  #TODO
  # Self-signed key will generate warnings
  #force_ssl unless Rails.env.test?

  def new

    #respond_to do |format|
    #  format.html {render 'new', layout: "welcome"}
    #end
  end

  def create
    user = user = User.first(conditions: {email: params[:email] } )
    if user && user.authenticate(params[:password])
      if params[:remember_me]
        cookies.permanent[:auth_token] = user.auth_token
      else
        cookies[:auth_token] = user.auth_token
      end

      redirect_back root_path
    else
      flash.now.alert = t("authentication.invalid_usr_pwd")
      render "new"
    end
  end

  def destroy
    cookies.delete :auth_token
    redirect_to root_url
  end

end