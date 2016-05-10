class CustomersController < ApplicationController
  # before_action :set_customer, only: [:show, :edit, :update, :destroy]

  # Customers Controller: Users who are looking for a Gig.

  # GET /customers
  # GET /customers.json
  def index
    @ip = request.remote_ip
    @location = request.location
    @city = @location.city.present? ? @location.city : 'Ogden'
    @state = @location.state.present? ? @location.state : 'UT'
    @range = params['range'].present? ? params['range'] : 100
    @gigs = []
    @profiles = Profile.near("#{@city}, #{@state}, US", @range).where(customer: true)
    @profiles.each do |profile|
      if profile.gigs.present?
        profile.gigs.each do |gig|
          @gigs << gig
        end
      end
    end
  end

  def gig
    @gig = Gig.find_by id: params[:id]
    @profile = Profile.find_by id: @gig.profile_id
  end

  def listgigs
    if current_user.id != params[:id].to_i
      redirect_to profile_path current_user.id
    end

    @profile = Profile.find_by(user_id: params[:id].to_i)

  end

  def search
    @ip = request.remote_ip
    @location = request.location
    @city = @location.city.present? ? @location.city : 'Ogden'
    @state = @location.state.present? ? @location.state : 'UT'
    @range = params['range'].present? ? params['range'] : 100
    @gigs = []
    @profiles = Profile.near("#{@city}, #{@state}, US", @range).where( customer: true, job_id: params["Job"][:job_id].to_i )
    @profiles.each do |profile|
      if profile.gigs.present?
        profile.gigs.each do |gig|
          @gigs << gig
        end
      end
    end
  end

  # GET /customers/1
  # GET /customers/1.json
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

  # GET /customers/new
  def new
    @customer = Customer.new
  end

  # GET /customers/1/edit
  def edit
  end

  # POST /customers
  # POST /customers.json
  def create
    @customer = Customer.new(customer_params)

    respond_to do |format|
      if @customer.save
        format.html { redirect_to @customer, notice: 'Customer was successfully created.' }
        format.json { render :show, status: :created, location: @customer }
      else
        format.html { render :new }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /customers/1
  # PATCH/PUT /customers/1.json
  def update
    respond_to do |format|
      if @customer.update(customer_params)
        format.html { redirect_to @customer, notice: 'Customer was successfully updated.' }
        format.json { render :show, status: :ok, location: @customer }
      else
        format.html { render :edit }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /customers/1
  # DELETE /customers/1.json
  def destroy
    @customer.destroy
    respond_to do |format|
      format.html { redirect_to customers_url, notice: 'Customer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def emailgig
    gig = Gig.find_by id: params[:gig]
    alfa = Profile.find_by id: gig.profile_id
    beta = Profile.find_by user_id: current_user.id
    alfa.send_message(beta, "Body", "subject")

    mail(
        :subject => 'Hello from Postmark',
        :to  => 'vin.hsieh@gmail.com',
        :from => 'postmaster@gigsley.com',
        :html_body => '<strong>Hello</strong> dear Postmark user.',
        :track_opens => 'true')

    redirect_to :back
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_customer
      @customer = Customer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def customer_params
      params.fetch(:customer, {})
    end
end
