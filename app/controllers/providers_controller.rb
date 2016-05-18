class ProvidersController < ApplicationController
  # before_action :set_provider, only: [:show, :edit, :update, :destroy]

  # Providers Controller: Users who are Providers and looking for customers.

  # GET /providers
  # GET /providers.json
  def index
    @ip = request.remote_ip
    @location = request.location
    @city = @location.city.present? ? @location.city : 'Ogden'
    @state = @location.state.present? ? @location.state : 'UT'
    @range = params['range'].present? ? params['range'] : 100
    @profiles = Profile.near("#{@city}, #{@state}, US", @range).where(provider: true)
  end

  def search
    @ip = request.remote_ip
    @location = request.location
    @search = nil
    @city = @location.city.present? ? @location.city : 'Ogden'
    @state = @location.state.present? ? @location.state : 'UT'
    @range = 100
    if params[:provider].present?
      @range = params[:provider][:range].present? ? params[:provider][:range] : 100
      @search = !params[:provider][:search].blank? ? params[:provider][:search] : ''
      @job = params[:provider][:job].present? ? params[:provider][:job].to_i : nil
    end

    @profiles = Profile.near("#{@city}, #{@state}, US", @range).where(provider: true)
    @profiles = @profiles.where( job_id: @job ) if @job != nil

    if @profiles.tagged_with(@search).length > 0
      @profiles = @profiles.tagged_with(@search)
    end

    @profiles.each do |profile|
      if profile.bio.present?
        @profiles << profile if (profile.bio.title.downcase.include? @search) || (profile.bio.experience.downcase.include? @search)
      end
    end if !@search.blank?

    # @profiles = Profile.near("#{@city}, #{@state}, US", @range).where( provider: true, job_id: params[:provider][:job].to_i )
  end

  # GET /providers/1
  # GET /providers/1.json
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

  # GET /providers/new
  def new
    @provider = Provider.new
  end

  # GET /providers/1/edit
  def edit
  end

  # POST /providers
  # POST /providers.json
  def create
    @provider = Provider.new(provider_params)

    respond_to do |format|
      if @provider.save
        format.html { redirect_to @provider, notice: 'Provider was successfully created.' }
        format.json { render :show, status: :created, location: @provider }
      else
        format.html { render :new }
        format.json { render json: @provider.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /providers/1
  # PATCH/PUT /providers/1.json
  def update
    respond_to do |format|
      if @provider.update(provider_params)
        format.html { redirect_to @provider, notice: 'Provider was successfully updated.' }
        format.json { render :show, status: :ok, location: @provider }
      else
        format.html { render :edit }
        format.json { render json: @provider.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /providers/1
  # DELETE /providers/1.json
  def destroy
    @provider.destroy
    respond_to do |format|
      format.html { redirect_to providers_url, notice: 'Provider was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_provider
      @provider = Provider.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def provider_params
      params.fetch(:provider, {})
    end
end
