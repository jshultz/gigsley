class RegistrationsController < Devise::RegistrationsController
  # One feature of rails is that it only allows white listed parameters to be accessed
  # Since the default devise controllers are in the gem, we can't add extra fields to the database unless we change the registrations controller.
  # Up top, you can see that we're inheriting from the Devise::RegistrationsController.
  # This means that all of our default Devise stuff works, and we can add some extras
  # In this case, I added the attributes name and bio to the model and changed the sign_up and account_update params to reflect that.
  private

  def sign_up_params
    params.require(:user).permit(:email, :password, :password_confirmation, :fullname, :avatar)
  end

  def account_update_params
    params.require(:user).permit(:email, :password, :password_confirmation, :fullname, :avatar)
  end
end
