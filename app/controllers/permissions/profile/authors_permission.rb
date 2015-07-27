module Profile
  class AuthorsPermission < BasePermission
    update_params :first_name, :last_name, :patronymic, :about_author, :enabled, :avatar
  end
end