class AuthorPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if @user.admin?
        scope
      else
        scope.only_enabled
      end
    end
  end
end