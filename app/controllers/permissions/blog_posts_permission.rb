class BlogPostsPermission < StrongPermitter::Permission::Base
  create_params :title, :content
end