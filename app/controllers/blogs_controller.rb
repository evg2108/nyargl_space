class BlogsController < ApplicationController
  include SimpleResourceLoader

  before_filter :do_authorize, only: [:new, :create]
  
  rescue_from(Pundit::NotAuthorizedError) do
    set_error_message :blog, :not_authorized
    redirect_to new_session_path
  end
  
  expose(:last_blog_posts) do
    blogs_by_id = {}
    blogs.each{ |b| blogs_by_id[b.id] = b }
    BlogPost.where(id: blogs.flat_map(&:last_blog_post_ids)).group_by{ |blog_post| blogs_by_id[blog_post.blog_id] }
  end

  helper_method :last_blog_posts_for

  def create
    blog.user = current_user
    if blog.save
      set_success_message :blog, :create
      redirect_to blog_path(blog)
    else
      set_error_message :blog, :create
      redirect_to new_blog_path
    end
  end

  private

  def last_blog_posts_for(blog)
    blog_posts = last_blog_posts[blog]
    if blog_posts.present?
      indexes_through_ids = {}
      blog_posts.each_with_index {|blog_post, index| indexes_through_ids[blog_post.id] = index }
      blog.last_blog_post_ids.map{ |blog_post_id| blog_posts[indexes_through_ids[blog_post_id]] }.compact
    end
  end
  
  def do_authorize
    authorize blog
  end
end