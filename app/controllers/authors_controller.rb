class AuthorsController < ApplicationController
  include Pundit
  include SimpleResourceLoader
  include SessionFileStorage

  self.per_page = 10

  rescue_from Pundit::NotAuthorizedError do
    respond_to do |format|
      format.html do
        set_error_message :profile, :not_authorized
        redirect_to root_path, status: 303
      end

      format.json do
        render json: { message: error_message(:profile, :not_authorized) }, status: :unprocessable_entity
      end
    end
  end

  def update
    authorize author
    result = author.save.present?
    respond_to do |format|
      format.html do
        if result
          set_success_message :author, :update
        else
          set_error_message(:author, :update)
        end
        redirect_to author_page_profile_path(anchor: CONTENT_SECTION)
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

  def author_params
    params.require(:author).permit(:first_name, :last_name, :patronymic, :about_author, :enabled)
  end
end
