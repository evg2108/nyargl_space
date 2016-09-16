module Profile
  class ProductsPermission < StrongPermitter::Permission::Base
    create_params :title, :description, :price, :age_restriction
    update_params :title, :description, :price, :age_restriction
  end
end