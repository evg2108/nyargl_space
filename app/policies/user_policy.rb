class UserPolicy < ApplicationPolicy
  def update?
    user.admin? || (!user.guest? && user.id == record.id)
  end
end