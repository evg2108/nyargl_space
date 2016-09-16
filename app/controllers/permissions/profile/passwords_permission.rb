module Profile
  class PasswordsPermission < StrongPermitter::Permission::Base
    self.resource_name = :user

    update_params :password
  end
end