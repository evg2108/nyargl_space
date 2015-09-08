class BlogPostsController < ApplicationController
  expose(:blog)
  expose(:blog_posts, ancestor: :blog)
  expose(:blog_post, attributes: :permitted_params)

  def create
    if blog_post.save
      set_simple_success_message 'Вы успешно создали новый пост.'
      redirect_to blog_post_path(blog_post)
    else
      set_simple_error_message 'Вам не удалось создать пост. Что-то пошло не так'
      redirect_to new_blog_blog_post_path(blog)
    end
  end
end