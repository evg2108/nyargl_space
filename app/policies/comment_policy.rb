class CommentPolicy < ApplicationPolicy
  def create?
    !user.guest?
  end

  def update?
    !user.guest? && record.commentator == user
  end

  def show?
    record && record.valid? && record.enabled?
  end

  # def permitted_attributes
  #   case action_name
  #     when 'create'
  #       [:content, :commentable_type, :commentable_id]
  #     when 'update'
  #       [:content]
  #     else
  #       []
  #   end
  # end

  # class Scope < Scope
  #   def resolve
  #     if @user.admin?
  #       scope.only_enabled
  #     else
  #       scope.only_enabled
  #     end
  #   end
  # end
end