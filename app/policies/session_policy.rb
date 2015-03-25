class SessionPolicy < ApplicationPolicy
  def create?
    user.guest?
  end
end