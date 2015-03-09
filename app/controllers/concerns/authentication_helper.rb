module AuthenticationHelper
  extend ActiveSupport::Concern

  included do
    # Prevent CSRF attacks by raising an exception.
    # For APIs, you may want to use :null_session instead.
    protect_from_forgery with: :exception

    expose(:current_user) { User.find(session[:user_id]) if session[:user_id].present? }

    expose(:logged_in?) { current_user.present? }
  end

  def log_in(user)
    session[:user_id] = user.id
  end

  def log_out
    session.delete(:user_id)
  end

end