class PasswordRegenerationPolicy < ApplicationPolicy
  def show?
    user.guest?
  end

  def create?
    user.guest?
  end
end