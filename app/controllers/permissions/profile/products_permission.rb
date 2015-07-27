module Profile
  class ProductsPermission < BasePermission
    create_params :title, :description, :price, :age_restriction
    update_params :title, :description, :price, :age_restriction
  end
end