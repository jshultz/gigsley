class ProfileController < ApplicationController

  def index
    @ip = request.remote_ip
    @location = request.location
    @city = @location.city.present? ? @location.city : 'Ogden'
    @state = @location.state.present? ? @location.state : 'UT'
    @range = params['range'].present? ? params['range'] : 100
    @profiles = Profile.near("#{@city}, #{@state}, US", @range)
  end

  def search

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
    @user = User.where(id: current_user.id).first
    if current_user.id != params[:id].to_i
      redirect_to profile_path
    end
  end

  def update
    @ip = request.remote_ip
    @user = User.where(id: current_user.id).first
    @profile = @user.create_profile(profile_params)
  end

  def vitals
    @user = User.where(id: current_user.id).first
    if request.post?
      @user.profile.update_attributes(profile_params)
    end
  end

  def create
    @ip = request.remote_ip
    params[:profile][:ip] = request.remote_ip
    params[:profile][:full_address] = params[:profile][:street] + ', ' + params[:profile][:city] + ', ' + params[:profile][:state]
    @user = User.where(id: current_user.id).first
    if @user.profile.blank?
      @user.create_profile(profile_params)
      redirect_to profile_path current_user.id
    else
      @user.profile.update_attributes(profile_params)
      if @user.profile.birthDate.blank?
        redirect_to vitals_path current_user.id
      else
        redirect_to profile_path current_user.id
      end

    end

  end

  private

  def profile_params
    params.require(:profile).permit(:street, :city, :state, :home_phone, :mobile_phone, :ip, :full_address, :phone, :displayPhone, :birthDate, :gender, :eligible )
  end
end
