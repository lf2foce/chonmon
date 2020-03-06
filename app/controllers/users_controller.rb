class UsersController < ApplicationController
  def show
    if current_user
      @location = current_user.locations.last #find(params[:id])
    end
  end

  def edit
  	@user = User.find(params[:id])
  end

  def update
	  current_user.update(user_params)
	  redirect_to current_user
  end

  def community
    @users = User.all
    @locations = Location.all
  end

  private
	def user_params
	  params.require(:user).permit(:user_name, :full_name, :website,
	                               :bio, :email, :phone, :gender, locations_attributes: [ :address, :latitude, :longitude])
	end
end
