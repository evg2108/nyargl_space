class ImagePlaceholder
  cattr_accessor :files_count, :files, :image_placeholders_path

  class << self
    def init(model_name, image_field_name, thumb = nil)
      self.image_placeholders_path ||= '/images/placeholders'

      model_name = model_name.to_s.singularize.to_sym
      image_field_name = image_field_name.to_s.singularize.to_sym
      thumb ||= :original

      self.files_count ||= {}
      self.files_count[model_name] ||= {}
      self.files_count[model_name][image_field_name] ||= {}
      self.files_count[model_name][image_field_name][thumb] ||= Dir[Rails.root + "public#{image_placeholders_path}/#{model_name}/#{image_field_name}/#{thumb}/*.jpg"].length

      self.files ||= {}
      self.files[model_name] ||= {}
      self.files[model_name][image_field_name] ||= {}
      unless self.files[model_name][image_field_name][thumb]
        self.files[model_name][image_field_name][thumb] = (1..self.files_count[model_name][image_field_name][thumb]).map { |index| "#{image_placeholders_path}/#{model_name}/#{image_field_name}/#{thumb}/#{index}.jpg" }
      end
    end

    def get_image_placeholder(model, image_field_name, thumb = nil)
      model_name = model.class.model_name.singular.to_sym
      image_field_name = image_field_name.to_s.singularize.to_sym
      thumb ||= :original

      files.try(:[], model_name)
           .try(:[], image_field_name)
           .try(:[], thumb)
           .try(:[], (model.id || 1).modulo(files_count.try(:[], model_name).try(:[], image_field_name).try(:[], thumb) || 1)) || ''
    end
  end
end