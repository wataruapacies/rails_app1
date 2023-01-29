class Users::RegistrationsController < Devise::RegistrationsController

  def after_sign_up_path_for(resource)
    flash[:notice_sign_up] = "successfully"
    user_path(current_user.id)
  end

end