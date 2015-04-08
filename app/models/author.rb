class Author < ActiveRecord::Base
  include FriendlyId

  friendly_id :full_name, use: [:slugged, :finders]

  belongs_to :user

  validates :first_name, presence: true

  scope :only_enabled, ->(){ where(enabled: true) }

  def full_name
    full_name_array = []
    full_name_array << last_name if last_name.present?
    full_name_array << first_name
    full_name_array << patronymic if patronymic.present?

    full_name_array.join(' ')
  end

  def has_slug?
    !changed_attributes.has_key?(:slug) || changed_attributes[:slug].present?
  end
end
