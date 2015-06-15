require 'keepass/password'

class PasswordRegenerationsController < ApplicationController
  include RecaptchaValidator

  rescue_from Pundit::NotAuthorizedError do
    redirect_to change_password_profile_path(anchor: Anchors::CONTENT_SECTION)
  end

  before_filter { authorize :password_regeneration }
  before_filter :validate_recaptcha, only: [:create]

  def create
    email = user_params[:email]
    user = User.find_by_email(email)

    if user
      new_password = KeePass::Password.generate('A{6}s{3}')
      temporary_token = Digest::MD5.hexdigest("#{new_password}#{Time.now}#{rand}")
      user.update_attributes(password: new_password, temporary_token: temporary_token)
      PasswordRegenerationMailer.send_new_password(user.email, new_password, temporary_token).deliver_later
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