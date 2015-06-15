class UsersController < ApplicationController
  include SessionFileStorage
  include RecaptchaValidator

  before_filter :authorize_for_registration, only: [:new, :create]
  before_filter :validate_recaptcha, only: [:create]

  expose(:user) do
    if get_id
      User.find(get_id)
    elsif params[:user]
      User.new(user_params)
    elsif in_session_file_storage?(:user)
      read_from_session_file_storage(User)
    else
      User.new
    end
  end

  def create
    temporary_token = Digest::MD5.hexdigest("#{user.email}#{Time.now}#{rand}")
    user.temporary_token = temporary_token
    if user.save
      RegistrationMailer.send_email_confirmation(user.email, user.password, user.temporary_token).deliver_later
      redirect_to root_path(anchor: Anchors::CONTENT_SECTION)
    else
      save_to_session_file_storage(user, :email, :password)
      redirect_to new_user_path(anchor: Anchors::CONTENT_SECTION)
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end

  def authorize_for_registration
    authorize :registration
  rescue Pundit::NotAuthorizedError
    redirect_to author_page_profile_path(anchor: Anchors::CONTENT_SECTION), status: 303
  end

  def get_id
    params[:id]
  end
end
