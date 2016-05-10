class ProfileController < ApplicationController

  def index
    @ip = request.remote_ip
    @location = request.location
    @city = @location.city.present? ? @location.city : 'Ogden'
    @state = @location.state.present? ? @location.state : 'UT'
    @range = params['range'].present? ? params['range'] : 100
    @profiles = Profile.near("#{@city}, #{@state}, US", @range)
    byebug
  end

  def search

  end

  def show
    @profile = Profile.where(user_id: params[:id].to_i).first
    if (current_user.id == params[:id].to_i) && @profile.blank?
      redirect_to edit_setup_path(current_user.id)
    end

    if @profile
      @user = @profile.user
    else
      @user = nil
    end
  end

  # Step 1
  def edit
    @user = User.where(id: current_user.id).first

    if request.post?
      if @user.profile.update_attributes profile_params
        redirect_to profile_path
      end
    end

    # if @user.profile.blank? || @user.profile.bio.blank?
    #   redirect_to edit_setup_path current_user.id
    # end
    # if current_user.id != params[:id].to_i
    #   redirect_to profile_path
    # end
  end


  def update
    @ip = request.remote_ip
    @user = User.where(id: current_user.id).first
    @user.profile.tag_list.add("awesome, slick", parse: true)
    @user.profile.skill_list.add(params[:tag_list])

    @profile = @user.create_profile(profile_params)
  end

  # Step 2
  def vitals
    @user = User.where(id: current_user.id).first
    if request.post?
      @user.profile.update_attributes(profile_params)
    end
  end

  # Step 3
  def bio
    @user = User.where(id: current_user.id).first
    if request.post?
      @user.profile.bio.update_attributes(bio_params)
    end
  end

  # Step 4
  def experience
    @user = User.where(id: current_user.id).first
    if request.post?
      if @user.profile.experience.update_attributes(experience_params)
        redirect_to profile_path
      end
    end
  end

  # Step 5
  def schedule
    @user = User.where(id: current_user.id).first
    if request.post?
      if @user.profile.schedule.update_attributes(schedule_params)
        redirect_to profile_path
      end
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
        redirect_to profile_vitals_path current_user.id
      else
        redirect_to profile_path current_user.id
      end
    end
  end

  private

  def profile_params
    params.require(:profile).permit(:street, :city, :state, :home_phone, :mobile_phone, :ip, :full_address, :phone, :displayPhone, :birthDate, :gender, :eligible, :skill_list, :provider, :customer, :job_id, :email, :name )
  end
  def bio_params
    params.require(:bio).permit(:title, :experience, :car, :pet, :smoke, :minHour, :maxHour, :travel)
  end
  def experience_params
    params.require(:experience).permit(:specialNeeds, :infants, :twins, :homework, :years, :sickChildren)
  end
  def schedule_params
    params.require(:schedule).permit(:shortNotice, :summerMonths, :beforeSchool, :afterSchool)
  end
end
