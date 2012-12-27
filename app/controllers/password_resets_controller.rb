class PasswordResetsController < ApplicationController
  def new
    respond_to do |format|
      format.html {render 'new', layout: "welcome"}
    end
  end

  def create
    user = User.find_by_email(params[:email])
    if user
      user.send_password_reset
      redirect_to new_password_reset_path, :notice => t("notices.password_reset_email_sent")
    else
      redirect_to new_password_reset_path, :alert => t("alerts.no_such_user")
    end
  end

  def edit
    @hide_menu = true
    @user = User.find_by_password_reset_token!(params[:id])

    if @user
      render :edit
    else
      redirect_to root_url, :notice => t("alerts.password_reset_invalid")
    end
  end

  def update

    @user = User.find_by_password_reset_token!(params[:id])

    if @user.password_reset_sent_at < 2.hours.ago
      redirect_to new_password_reset_path, :alert => t("alerts.password_reset_expired")
    elsif @user.update_attributes(params[:user])
      redirect_to login_path, :notice => t("notices.password_reset")
    else
      render :edit
    end
  end
end
