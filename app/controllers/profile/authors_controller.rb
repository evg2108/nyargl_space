module Profile
  class AuthorsController < Profile::BaseController
    expose(:author) do
      current_author.attributes = permitted_params if current_author && action_name == 'update'
      current_author
    end

    def update
      result = author.save
      respond_to do |format|
        format.html do
          if result
            set_success_message :author, :update
          else
            set_error_message(:author, :update)
          end
          redirect_to profile_author_path(anchor: anchor)
        end

        format.json do
          if result
            render json: { success: true }
          else
            render json: { message: error_message(:author, :update) }, status: :unprocessable_entity
          end
        end
      end
    end

    private

    def do_authorize
      if action_name == 'update'
        authorize author || Author
      else
        super
      end
    end
  end
end