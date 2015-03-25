class SessionsController < ApplicationController
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

  private

  def try_autenticate
    user = User.find_by_email(params[:user][:email])
    if user && user.authenticate(params[:user][:password])
      log_in user
    else
      set_error_message :authentication
    end
  end
end
