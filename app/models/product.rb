class Product < ActiveRecord::Base
  include FriendlyId

  friendly_id :title, use: [:slugged, :finders]

  mount_uploaders :pictures, ProductPictureUploader

  belongs_to :user
end
