class SessionsController < ApplicationController
  include RecaptchaValidator

  rescue_from Pundit::NotAuthorizedError, with: :not_authorized

  before_filter(only: [:new, :create]) { authorize :session }
  before_filter :validate_recaptcha, only: [:create]

  def create
    try_autenticate
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
        user.update_attribute(:temporary_token, nil)
        redirect_to change_password_profile_path(anchor: CONTENT_SECTION)
        return
      end
    end
    redirect_to root_path(anchor: CONTENT_SECTION)
  end

  private

  def try_autenticate
    user = User.find_by_email(params[:user][:email])
    if user && user.authenticate(params[:user][:password])
      log_in user
    else
      set_error_message :authentication, :bad_data
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
