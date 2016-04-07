class ProfileController < ApplicationController

  def index

  end

  def show

  end

  def edit

  end

  def update
    byebug
    @profile = @user.create_profile(params)
    # need to handle *** ActiveModel::ForbiddenAttributesError Exception: ActiveModel::ForbiddenAttributesError
  end

  def create
    byebug
    @profile = @user.create_profile(params)
    # need to handle *** ActiveModel::ForbiddenAttributesError Exception: ActiveModel::ForbiddenAttributesError
  end
end
