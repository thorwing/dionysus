class RegistrationsController < Devise::RegistrationsController
  def update
    if params[resource_name][:avatar].blank?
      super
    else
      respond_to do |format|
        if resource.update_with_password(params[resource_name])
          format.html { render :action => 'crop'}
          format.xml  { head :ok }
        else
          format.html { render :action => "edit" }
        end
      end
    end
  end

  def crop

  end

  def crop_update
    current_user.crop_x = params[:avatar]["crop_x"]
    current_user.crop_y = params[:avatar]["crop_y"]
    current_user.crop_h = params[:avatar]["crop_h"]
    current_user.crop_w = params[:avatar]["crop_w"]
    current_user.save

    respond_to do |format|
      format.html {redirect_to settings_path}
    end
  end
end