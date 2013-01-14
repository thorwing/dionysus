class LocationsController < ApplicationController
  before_filter :preload

  def show
    @location = @user.location
  end

  def edit
    @location = @user.location || Location.new
  end

  def update
    @location = @user.location

    respond_to do |format|
      if @location.update_attributes(params[:location])
        format.html { redirect_to [@user, @location], notice: 'Location was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  def create
    if @user.location
      redirect_to :back
      return
    end

    @location = @user.build_location(params[:location])

    respond_to do |format|
      if @location.save
        format.html { redirect_to [@user, @location], notice: 'Location was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  def preload
    begin
      @user = User.find(params[:user_id])
    rescue
      not_found
    end
  end

end
