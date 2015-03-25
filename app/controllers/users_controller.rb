class UsersController < ApplicationController
  include SessionFileStorage

  before_filter { authorize :registration, :create? }

  rescue_from Pundit::NotAuthorizedError do
    redirect_to author_page_profile_path(anchor: CONTENT_SECTION), status: 303
  end

  expose(:user) do
    if params[:user]
      User.new(user_params)
    elsif in_session_file_storage?(:user)
      read_from_session_file_storage(User)
    else
      User.new
    end
  end

  def create
    if user.save
      redirect_to root_path
    else
      save_to_session_file_storage(user, :email, :password)
      redirect_to new_user_path(anchor: CONTENT_SECTION)
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
