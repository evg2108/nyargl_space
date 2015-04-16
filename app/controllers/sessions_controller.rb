class SessionsController < ApplicationController
  include RecaptchaValidator

  rescue_from Pundit::NotAuthorizedError, with: :not_authorized

  before_filter(only: [:new, :create]) { authorize :session }
  before_filter :validate_recaptcha, :check_email_confirmation, :autenticate, only: [:create]

  expose(:user) { User.find_by_email(params[:user][:email]) }

  def create
    redirect_to root_path(anchor: CONTENT_SECTION)
  end

  def destroy
    log_out
    redirect_to root_path(anchor: CONTENT_SECTION)
  end

  def once_login
    email = params[:email]
    token = params[:temporary_token]
    if email.present? && token.present?
      user = User.find_by_email email
      if user.temporary_token == token
        log_in user
        user.update_attributes(temporary_token: nil, confirmed_email: true)
        redirect_to change_password_profile_path(anchor: CONTENT_SECTION)
        return
      end
    end
    redirect_to root_path(anchor: CONTENT_SECTION)
  end

  private

  def check_email_confirmation
    unless user.confirmed_email?
      set_error_message :authentication, :email_not_confirmed
      redirect_to new_session_path(anchor: CONTENT_SECTION)
    end
  end

  def autenticate
    if user && user.authenticate(params[:user][:password])
      log_in user
    else
      set_error_message :authentication, :bad_data
      redirect_to new_session_path(anchor: CONTENT_SECTION)
    end
  end

  def not_authorized(exception)
    case action_name
      when 'create'
        redirect_to author_page_profile_path(anchor: CONTENT_SECTION), status: 303
      else
        redirect_to root_path(anchor: CONTENT_SECTION), status: 303
    end
  end
end
