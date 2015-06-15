module Profile
  class BaseController < ApplicationController
    include Pundit

    before_filter :do_authorize, :define_page_title

    layout 'profile'

    expose(:profile_tabs){
      [
          MenuItem.new('profile.author_page', 'profile/authors', :show),
          MenuItem.new('profile.products', 'profile/products', :index),
          MenuItem.new('profile.change_password', 'profile/passwords', :edit)
      ]
    }

    rescue_from(Pundit::NotAuthorizedError){ authorization_error }

    private

    def anchor
      params[:anchor] || CONTENT_SECTION
    end

    def define_page_title
      set_page_title 'Настройки профиля'
    end

    def do_authorize
      authorize :profile, :show?
    end

    def authorization_error
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
  end
end