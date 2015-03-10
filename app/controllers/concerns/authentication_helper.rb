module AuthenticationHelper
  extend ActiveSupport::Concern

  included do
    # Prevent CSRF attacks by raising an exception.
    # For APIs, you may want to use :null_session instead.
    protect_from_forgery with: :exception

    expose(:current_user) { logged_in? ? User.find(session[:user_id]) : User.new(role: Roles.guest_role).freeze }

    expose(:logged_in?) { session[:user_id].present? }
  end

  def log_in(user)
    session[:user_id] = user.id
  end

  def log_out
    session.delete(:user_id)
  end

end