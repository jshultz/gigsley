class Users::InvitationsController < Devise::InvitationsController
  def after_invite_path_for(resource)
    students_path
  end
end