class RegistrationPolicy < ApplicationPolicy
  def create?
    user.guest?
  end
end