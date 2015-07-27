module Profile
  class PasswordsPermission < BasePermission
    self.resource_name = :user

    update_params :password
  end
end