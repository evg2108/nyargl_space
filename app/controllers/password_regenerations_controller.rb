require 'keepass/password'

class PasswordRegenerationsController < ApplicationController
  before_filter { authorize :password_regeneration }

  rescue_from Pundit::NotAuthorizedError do
    redirect_to change_password_profile_path(anchor: CONTENT_SECTION)
  end

  def create
    email = user_params[:email]
    user = User.find_by_email(email)

    if user
      #TODO сгенерировать новый пароль и выслать в письме, оповестить польователя об успехе
      new_password = KeePass::Password.generate('A{6}s{3}')
      user.update_attribute(:password, new_password)
      PasswordRegeneration.send_new_password(user.email, new_password).deliver_later
      set_success_message :password_regenerations
    else
      set_error_message :password_regenerations, :email, :not_found
    end
    redirect_to password_regeneration_path, status: 303
  end

  private

  def user_params
    params.require(:user).permit(:email)
  end
end