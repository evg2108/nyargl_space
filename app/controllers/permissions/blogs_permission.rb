class BlogsPermission < StrongPermitter::Permission::Base
  create_params :title, :description
end