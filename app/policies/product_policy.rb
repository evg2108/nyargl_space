class ProductPolicy < ApplicationPolicy
  def update?
    !user.guest? && user == record.user
  end
end