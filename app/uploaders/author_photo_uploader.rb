class AuthorPhotoUploader < BaseUploader
  version :medium_image do
    resize_to_limit 482, ''
  end

  version :small_thumb do
    resize_to_fill 100, 100
  end
end