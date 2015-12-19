class PasswordRegenerationsPermission < StrongPermitter::Permission::Base
  self.resource_name = :user

  create_params :email
end