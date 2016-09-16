class BlogPostPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.order(created_at: :desc)
    end
  end
end