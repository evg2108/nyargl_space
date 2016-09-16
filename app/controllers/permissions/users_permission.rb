class UsersPermission < StrongPermitter::Permission::Base
  create_params :email, :password
end