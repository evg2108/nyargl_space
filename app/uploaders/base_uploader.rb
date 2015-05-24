# encoding: utf-8
class BaseUploader < CarrierWave::Uploader::Base

  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  include CarrierWave::MiniMagick

  process :set_content_type

  # автоматическое определение типа файла по его содержимому
  def set_content_type
    file.content_type = IO.popen(['file', '--brief', '--mime-type', path], in: :close, err: :close).read.chomp
  end

  # Choose what kind of storage to use for this uploader:
  storage :file
  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Process files as they are uploaded:
  # process :scale => [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:
  # version :thumb do
  #   process :resize_to_fit => [50, 50]
  # end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_white_list
    %w(jpg jpeg gif png)
  end

  def filename
    "#{cache_name.split('/').first}.#{extension}" if cache_name
  end

  private

  # Автоматическое определение расширения файла по его типу
  def extension(target_file = nil)
    target_file ||= self.file
    @_extension ||= case target_file.content_type
                      when 'image/pjpeg'
                        'jpg'
                      when 'image/x-png'
                        'phg'
                      else
                        Rack::Mime::MIME_TYPES.invert[target_file.content_type][1..-1]
                    end
  end

  # Переопределяем стандартный метод Carrierwave, чтобы использовать автоматически определяемое расширение файла
  def check_whitelist!(new_file)
    target_extension = extension(new_file)
    if extension_white_list and not extension_white_list.detect { |item| target_extension =~ /\A#{item}\z/i }
      raise CarrierWave::IntegrityError, I18n.translate('errors.messages.extension_white_list_error', extension: target_extension.inspect, allowed_types: extension_white_list.join(', '))
    end
  end

  # Переопределяем стандартный метод Carrierwave, чтобы использовать автоматически определяемое расширение файла
  def check_blacklist!(new_file)
    target_extension = extension(new_file)
    if extension_black_list and extension_black_list.detect { |item| target_extension =~ /\A#{item}\z/i }
      raise CarrierWave::IntegrityError, I18n.translate('errors.messages.extension_black_list_error', extension: target_extension.inspect, prohibited_types: extension_black_list.join(', '))
    end
  end

end
