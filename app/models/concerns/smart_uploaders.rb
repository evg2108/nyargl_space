module SmartUploaders
  extend ActiveSupport::Concern

  class_methods do
    def mount_smart_uploaders(field, uploader_class)
      mount_uploaders field, uploader_class

      define_method "append_#{field}" do |images|
        appended_images = images.map do |image|
          uploader = uploader_class.new(self, field)
          uploader.store! image
          uploader
        end
        self[field] ||= []
        self[field] += appended_images.map{ |uploader| uploader.file.filename }
      end

      define_method "remove_#{field.to_s.singularize}" do |image_name|
        photo_for_deleting = public_send(field).detect { |photo| photo.file.basename == image_name }
        filename = photo_for_deleting.file.filename
        if photo_for_deleting
          photo_for_deleting.remove!
          self[field] -= [filename]
        end
      end
    end

  end
end