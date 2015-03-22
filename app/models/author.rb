class Author < ActiveRecord::Base
  belongs_to :user

  validates :first_name, presence: true

  scope :only_enabled, ->(){ where(enabled: true) }
end
