class Product < ActiveRecord::Base
  include FriendlyId
  include SmartUploaders

  friendly_id :title, use: [:slugged, :finders]

  mount_smart_uploaders :pictures, ProductPictureUploader

  belongs_to :user
  has_one :author, through: :user
  has_many :comments, as: :commentable

  attr_readonly :comments_count

  enum age_restriction: { ar0: 0, ar6: 6, ar12: 12, ar16: 16, ar18: 18 }

  def self.localized_age_restrictions
    return @_localized_age_restrictions if defined? @_localized_age_restrictions
    @_localized_age_restrictions = age_restrictions.keys.map do |key|
      [I18n.t("activerecord.attributes.product.age_restriction.#{key}", default: key), key]
    end
  end
end
