class BlogPost < ActiveRecord::Base
  belongs_to :blog, inverse_of: :blog_posts
  has_one :user, through: :blog

  after_create :set_as_last

  private

  def set_as_last
    blog.update_attribute :last_blog_post_ids, ([id] + blog.last_blog_post_ids).take(6)
  end
end