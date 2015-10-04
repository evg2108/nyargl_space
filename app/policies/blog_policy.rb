class BlogPolicy < ApplicationPolicy
  def new?
    create?
  end

  def create?
    !user.guest?
  end

  def update?
    !user.guest? && user == record.user
  end

  class Scope < Scope
    def resolve
      scope.order(updated_at: :desc)
    end
  end
end