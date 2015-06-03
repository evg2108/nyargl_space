class UsersController < ApplicationController
  include SessionFileStorage
  include RecaptchaValidator

  before_filter :authorize_for_registration, only: [:new, :create]
  before_filter :validate_recaptcha, only: [:create]

  expose(:user) do
    if get_id
      result = User.find(get_id)
      if (parameters = user_params)
        result.attributes = parameters
      end
      result
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
      redirect_to root_path(anchor: CONTENT_SECTION)
    else
      save_to_session_file_storage(user, :email, :password)
      redirect_to new_user_path(anchor: CONTENT_SECTION)
    end
  end

  def update
    authorize user
    success = user.save

    respond_to do |format|
      format.html do
        if success
          set_success_message :user, :password_changed
        else
          set_error_message :user, :empty_password
        end
        redirect_to change_password_profile_path(anchor: CONTENT_SECTION)
      end

      format.json do
        if success
          render json: { message: success_message(:user, :password_changed) }
        else
          render json: { message: error_message(:user, :empty_password) }, status: :unprocessable_entity
        end
      end
    end
  rescue Pundit::NotAuthorizedError
    redirect_to root_path(anchor: CONTENT_SECTION), status: 303
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end

  def authorize_for_registration
    authorize :registration
  rescue Pundit::NotAuthorizedError
    redirect_to author_page_profile_path(anchor: CONTENT_SECTION), status: 303
  end

  def get_id
    if action_name == 'update'
      current_user.id
    else
      params[:id]
    end
  end
end
