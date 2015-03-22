module AuthenticationHelper
  extend ActiveSupport::Concern

  included do
    # Prevent CSRF attacks by raising an exception.
    # For APIs, you may want to use :null_session instead.
    protect_from_forgery with: :exception

    expose(:current_user) { session[:user_id].present? && (user = User.where(id: session[:user_id]).first) ? user : User.new(role: Roles.guest_role).freeze }

    expose(:logged_in?) { !current_user.guest?  }

    expose(:current_author) do
      if logged_in?
        unless (result = current_user.author)
          result = Author.new(user_id: current_user.id)
          result.save(validate: false)
        end
        result.valid?
        result
      end
    end
  end

  def log_in(user)
    session[:user_id] = user.id
  end

  def log_out
    session.delete(:user_id)
  end

end