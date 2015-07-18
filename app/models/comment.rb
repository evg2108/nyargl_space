class Comment < ActiveRecord::Base
  belongs_to :commentable, polymorphic: true

  belongs_to :commentator, class_name: 'User'
  belongs_to :reply_commentator, class_name: 'User'

  scope :only_enabled, ->(){ where(enabled: true) }
end