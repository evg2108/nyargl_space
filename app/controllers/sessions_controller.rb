class SessionsController < ApplicationController
  def new
    authorize :session
  rescue Pundit::NotAuthorizedError
    redirect_to root_path(anchor: CONTENT_SECTION), status: 303
  end

  def create
    authorize :session
    try_autenticate
    redirect_to :back
  rescue Pundit::NotAuthorizedError
    redirect_to author_page_profile_path(anchor: CONTENT_SECTION), status: 303
  end

  def destroy
    log_out
    redirect_to root_path
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
    redirect_to root_path
  end

  private

  def try_autenticate
    unless verify_recaptcha
      set_error_message :authentication, :bad_recaptcha
      return
    end

    user = User.find_by_email(params[:user][:email])
    if user && user.authenticate(params[:user][:password])
      log_in user
    else
      set_error_message :authentication, :bad_data
    end
  end
end
