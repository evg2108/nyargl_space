class RegistrationPolicy < ApplicationPolicy
  def create?
    user.guest?
  end

  def update?
    !user.guest? && user
  end
end