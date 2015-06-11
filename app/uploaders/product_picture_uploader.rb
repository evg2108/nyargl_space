class ProductPictureUploader < BaseUploader
  version :small_thumb do
    resize_to_fill 100, 100
  end
end