module Profile
  class ProductsController < Profile::BaseController
    include Pundit

    expose(:product, attributes: :product_params)
    expose(:products) { current_user.products }

    def create
      product.user = current_user
      product.save
      redirect_to profile_products_path
    end

    def update
      product.save
      redirect_to profile_products_path
    end

    def destroy
      product.destroy
      redirect_to :back
    end

    private

    def product_params
      params.require(:product).permit(:title, :description, :price, :age_restriction)
    end
  end
end