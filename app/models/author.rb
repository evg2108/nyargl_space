class Author < ActiveRecord::Base
  belongs_to :user

  scope :only_enabled, ->(){ where(enabled: true) }
end
