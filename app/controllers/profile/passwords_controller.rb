module Profile
  class PasswordsController < Profile::BaseController
    expose(:user) do
      current_user.attributes = user_params if !current_user.guest? && action_name == 'update'
      current_user
    end

    def update
      success = user.save

      respond_to do |format|
        format.html do
          if success
            set_success_message :user, :password_changed
          else
            set_error_message :user, :empty_password
          end
          redirect_to edit_profile_password_path(anchor: Anchors::CONTENT_SECTION)
        end

        format.json do
          if success
            render json: { message: success_message(:user, :password_changed) }
          else
            render json: { message: error_message(:user, :empty_password) }, status: :unprocessable_entity
          end
        end
      end
    end

    private

    def user_params
      params.require(:user).permit(:password)
    end

    def do_authorize
      if action_name == 'update'
        authorize user
      else
        super
      end
    end
  end
end