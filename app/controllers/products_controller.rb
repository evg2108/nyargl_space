class ProductsController < ApplicationController
  include Pundit
  include SimpleResourceLoader

  self.per_page = 10

  expose(:profile_tabs){
    [
        MenuItem.new('profile.author_page', :profiles, :author_page),
        MenuItem.new('profile.products', :profiles, :products),
        MenuItem.new('profile.change_password', :profiles, :change_password)
    ]
  }

  def create
    product.user = current_user
    product.save
    redirect_to controlled_product_index_path
  end

  def update
    product.save
    redirect_to controlled_product_index_path
  end

  def destroy
    product.destroy
    redirect_to :back
  end

  private

  def product_params
    params.require(:product).permit(:title, :description)
  end
end