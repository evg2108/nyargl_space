class Comment < ActiveRecord::Base
  belongs_to :commentable, polymorphic: true, counter_cache: true

  belongs_to :commentator, class_name: 'User'
  belongs_to :reply_commentator, class_name: 'User'

  validates :content, presence: true

  scope :only_enabled, ->(){ where(enabled: true) }
end