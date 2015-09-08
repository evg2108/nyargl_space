class Blog < ActiveRecord::Base
  belongs_to :user
  has_many :blog_posts

  validates :title, presence: true
end