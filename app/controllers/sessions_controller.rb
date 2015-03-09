class SessionsController < ApplicationController
  def create
    try_autenticate
    redirect_to :back
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
