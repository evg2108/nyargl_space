module Profile
  class ProductsController < Profile::BaseController
    include Pundit

    expose(:product, attributes: :permitted_params)
    expose(:products) { current_user.products }

    def create
      product.user = current_user
      product.save
      redirect_to edit_profile_product_path(product)
    end

    def update
      product.save
      redirect_to profile_products_path
    end

    def destroy
      product.destroy
      redirect_to :back
    end
  end
end