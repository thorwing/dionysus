class ComplainsController < ApplicationController
  def create
    @complain = Complain.new(params[:complain])
    @complain.author = current_user

    respond_to do |format|
      if @complain.save
        format.html { redirect_to @complain.complainable, notice: 'Complain was successfully created.' }
      else
        format.html { redirect_to @complain.complainable, error: 'Faild to create complain.' }
      end
    end
  end
end
