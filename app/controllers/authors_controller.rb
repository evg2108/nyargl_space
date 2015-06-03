class AuthorsController < ApplicationController
  include Pundit
  include SimpleResourceLoader
  include SessionFileStorage

  self.per_page = 10

  before_filter :authorization, only: [:show, :update]

  rescue_from(Pundit::NotAuthorizedError){ send("authorization_error_#{action_name}") }

  def update
    result = author.save
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
    params.require(:author).permit(:first_name, :last_name, :patronymic, :about_author, :enabled, :avatar)
  end

  def authorization
    authorize author
  end

  def authorization_error_update
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

  def authorization_error_show
    set_error_message :author, :show, :not_active
    redirect_to author_page_profile_path, status: 303
  end

  def get_id
    if action_name == 'update'
      current_author.id
    else
      params[:id]
    end
  end
end
