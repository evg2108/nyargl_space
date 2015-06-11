class ProfilesController < ApplicationController
  before_filter { authorize :profile, :show? }
  before_filter(only: [:author_page, :change_password, :products]) { render 'profiles/show' }

  expose(:profile_tabs){
    [
        MenuItem.new('profile.author_page', :profiles, :author_page),
        MenuItem.new('profile.products', :profiles, :products),
        MenuItem.new('profile.change_password', :profiles, :change_password)
    ]
  }

  rescue_from Pundit::NotAuthorizedError do
    set_error_message :profile, :not_authorized
    redirect_to root_path, status: 303
  end

  def author_page; end
  def products; end
  def change_password; end
end
