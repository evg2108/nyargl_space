class BlogsController < ApplicationController
  expose(:blogs)
  expose(:blog, attributes: :permitted_params)

  expose(:last_blog_posts) do
    blogs_by_id = {}
    blogs.each{ |b| blogs_by_id[b.id] = b }
    BlogPost.where(id: blogs.flat_map(&:last_blog_post_ids)).group_by{ |blog_post| blogs_by_id[blog_post.blog_id] }
  end

  helper_method :last_blog_posts_for

  def create
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
end