class CommentsPermission < BasePermission
  create_params :content, :commentable_type, :commentable_id
  update_params :content
end