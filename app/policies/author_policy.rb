class AuthorPolicy < ApplicationPolicy
  def update?
    !user.guest? && user.author == record
  end

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