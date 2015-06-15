class AuthorsController < ApplicationController
  include Pundit
  include SimpleResourceLoader

  self.per_page = 10

  before_filter :authorization, only: [:show]

  rescue_from(Pundit::NotAuthorizedError){ authorization_error }

  private

  def authorization
    authorize author
  end

  def authorization_error
    set_error_message :author, :show, :not_active
    redirect_to profile_author_path, status: 303
  end
end
