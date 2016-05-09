class SetupsController < ApplicationController

  # GET /setups
  # GET /setups.json
  def index
    @setups = Setup.all
  end

  # GET /setups/1
  # GET /setups/1.json
  def show
  end

  # GET /setups/new
  def new
    @setup = Setup.new
  end

  # GET /setups/1/edit
  def edit
    @user = User.where(id: current_user.id).first
    if current_user.id != params[:id].to_i
      redirect_to profile_path
    end
  end

  # POST /setups
  # POST /setups.json
  def create
    @ip = request.remote_ip
    params[:profile][:ip] = request.remote_ip
    params[:profile][:full_address] = params[:profile][:street] + ', ' + params[:profile][:city] + ', ' + params[:profile][:state]
    @user = User.where(id: current_user.id).first
    if @user.profile.blank?
      if @user.create_profile(profile_params)
        @user.profile.skill_list.add(params[:tag_list])
        redirect_to setup_jobs_path current_user.id
      else
        redirect_to setup_thankyou_path
      end
    end
  end

  # PATCH/PUT /setups/1
  # PATCH/PUT /setups/1.json
  # def update
  #   respond_to do |format|
  #     if @setup.update(setup_params)
  #       format.html { redirect_to @setup, notice: 'Setup was successfully updated.' }
  #       format.json { render :show, status: :ok, location: @setup }
  #     else
  #       format.html { render :edit }
  #       format.json { render json: @setup.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # Step 2
  def jobs
    @user = User.where(id: current_user.id).first
    if request.post?

      if @user.profile.update_attributes(profile_params)

        if @user.profile.customer == true
          redirect_to setup_gigs_path current_user.id
        elsif @user.profile.provier == true
          redirect_to setup_vitals_path current_user.id
        else
          redirect_to setup_thankyou_path
        end

      end

    end
  end

  # Step 2a
  def gigs
    @user = User.where(id: current_user.id).first
    if request.post?
      if @user.profile.gigs.create(gigs_params)
        redirect_to setup_vitals_path current_user.id
      end
    end
  end

  # Step 3
  def vitals
    @user = User.where(id: current_user.id).first
    if request.post?
      if @user.profile.update_attributes(profile_params)
        redirect_to setup_bio_path current_user.id
      end
    end
  end

  # Step 4
  def bio
    @user = User.where(id: current_user.id).first
    if request.post?
      if @user.profile.create_bio(bio_params)
        redirect_to setup_experience_path current_user.id
      end
    end
  end

  # Step 5
  def experience
    @user = User.where(id: current_user.id).first
    if request.post?
      if @user.profile.create_experience(experience_params)
        redirect_to setup_schedule_path current_user.id
      end
    end
  end

  # Step 6
  def schedule
    @user = User.where(id: current_user.id).first
    if request.post?
      if @user.profile.create_schedule(schedule_params)
        redirect_to setup_thankyou_path
      end
    end
  end

  # Thank You
  def thankyou
    @user = User.where(id: current_user.id).first
  end

  # DELETE /setups/1
  # DELETE /setups/1.json
  def destroy
    @setup.destroy
    respond_to do |format|
      format.html { redirect_to setups_url, notice: 'Setup was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.

    # Never trust parameters from the scary internet, only allow the white list through.
    def setup_params
      params.fetch(:setup, {})
    end
    def profile_params
      params.require(:profile).permit(:street, :city, :state, :home_phone, :mobile_phone, :ip, :full_address, :phone, :displayPhone, :birthDate, :gender, :eligible, :skill_list, :provider, :customer, :job_id, :email )
    end
    def bio_params
      params.require(:bio).permit(:title, :experience, :car, :pet, :smoke, :minHour, :maxHour, :travel)
    end
    def experience_params
      params.require(:experience).permit(:specialNeeds, :infants, :twins, :homework, :years, :sickChildren)
    end
    def gigs_params
      params.require(:gig).permit(:jobName, :description, :awarded, :job_id, :profile_id)
    end
    def schedule_params
      params.require(:schedule).permit(:shortNotice, :summerMonths, :beforeSchool, :afterSchool)
    end
end
