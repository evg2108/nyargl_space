class ProfilePolicy < ApplicationPolicy
  def show?
    !user.guest?
  end
end