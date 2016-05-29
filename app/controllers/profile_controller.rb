class ProfileController < ApplicationController

  before_action :set_user, only: [:show, :edit, :update, :availability, :bio, :experience, :schedule, :vitals]

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

    if request.post?
      @profile = Profile.find_by user_id: current_user.id

      if @profile.update_attributes profile_params
        redirect_to profile_path
      else
        render :edit, flash: @profile.errors
      end
    end

  end


  def update
    @ip = request.remote_ip
    @user.profile.tag_list.add("awesome, slick", parse: true)
    @user.profile.skill_list.add(params[:tag_list])
    @profile = @user.create_profile(profile_params)
  end

  # Step 2
  def vitals
    if request.post?
      @user.profile.update_attributes(profile_params)
    end
  end

  # Step 3
  def bio
    if request.post?
      params[:bio][:profile_id] = @user.profile.id
      @bio = Bio.find_by profile_id: @user.profile.id

      if @bio.update_attributes(bio_params)
        redirect_to profile_path
      else
        render :bio, flash: @bio.errors
      end

    end
  end

  # Step 4
  def experience
    if request.post?
      if @user.profile.experience.update_attributes(experience_params)
        redirect_to profile_path
      end
    end
  end

  # Step 5
  def schedule
    if request.post?
      if @user.profile.schedule.update_attributes(schedule_params)
        redirect_to profile_path
      end
    end
  end

  def availability
    if request.post?
      @user = User.where(id: current_user.id).first
      count = 0
      if params[:day].present?
        params[:day].each_with_index { |day,index|
          @availability = Availability.find_or_create_by(day_of_week: index, profile_id: @user.profile.id)
          availability_params = {
              day_of_week: index,
              earlyMorning: day.last[:earlyMorning].to_i,
              lateMorning: day.last[:lateMorning].to_i,
              earlyAfternoon: day.last[:earlyAfternoon].to_i,
              lateAfternoon: day.last[:lateAfternoon].to_i,
              earlyEvening: day.last[:earlyEvening].to_i,
              lateEvening: day.last[:lateEvening].to_i,
              overnight: day.last[:overnight].to_i,
              profile_id: @user.profile.id
          }
          @availability.update_attributes(availability_params)
          count += 1
        }
        if count == 7
          redirect_to profile_schedule_path
        end
      end

    end
  end

  def create
    @ip = request.remote_ip
    params[:profile][:ip] = request.remote_ip
    params[:profile][:full_address] = params[:profile][:street] + ', ' + params[:profile][:city] + ', ' + params[:profile][:state]
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

  def set_user
    @user = User.find_by(id: current_user.id)
  end
  def profile_params
    params.require(:profile).permit(:street, :city, :state, :home_phone, :mobile_phone, :ip, :full_address, :phone, :displayPhone, :birthDate, :gender, :eligible, :skill_list, :provider, :customer, :job_id, :email, :name, :user_id, :tag_list )
  end
  def bio_params
    params.require(:bio).permit(:title, :experience, :car, :pet, :smoke, :minHour, :maxHour, :travel, :profile_id)
  end
  def experience_params
    params.require(:experience).permit(:specialNeeds, :infants, :twins, :homework, :years, :sickChildren, :profile_id)
  end
  def schedule_params
    params.require(:schedule).permit(:shortNotice, :summerMonths, :beforeSchool, :afterSchool, :profile_id)
  end
  def availability_params
    params.permit(:start_at, :end_at, :day_of_week, :earlyMorning, :lateMorning, :earlyAfternoon, :lateAfternoon, :earlyEvening, :overnight, :profile_id, :gig_sched_id)
  end
end
