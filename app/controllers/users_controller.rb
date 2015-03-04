class UsersController < ApplicationController
  expose(:user, attributes: :user_params)

  def create
    if user.save
      redirect_to root_path
    else
      self.action_name = 'new'
      render 'users/new'
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
