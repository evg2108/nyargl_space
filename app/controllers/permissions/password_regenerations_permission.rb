class PasswordRegenerationsPermission < BasePermission
  self.resource_name = :user

  create_params :email
end