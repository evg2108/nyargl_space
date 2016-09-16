class Blog < ActiveRecord::Base
  belongs_to :user
  has_many :blog_posts, inverse_of: :blog

  validates :title, presence: true
end