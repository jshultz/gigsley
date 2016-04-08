class ProfileController < ApplicationController

  def index

  end

  def show
    @profile = Profile.where(user_id: params[:id].to_i).first
    if @profile
      @user = @profile.user
    else
      @user = nil
    end

  end

  def edit
    if current_user.id != params[:id].to_i
      redirect_to profile_path
    end
  end

  def update
    @user = User.where(id: current_user.id).first
    @profile = @user.create_profile(profile_params)
  end

  def create
    @user = User.where(id: current_user.id).first
    if @user.profile.nil?
      @user.create_profile(profile_params)
      redirect_to profile_path current_user.id
    else
      @user.profile.update_attributes(profile_params)
      redirect_to profile_path current_user.id
    end

  end

  private

  def profile_params
    params.require(:profile).permit(:street, :city, :state, :home_phone, :mobile_phone)
  end
end
