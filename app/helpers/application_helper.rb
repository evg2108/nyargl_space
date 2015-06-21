module ApplicationHelper
  def current_asset_name
    @current_asset_name ||= "application/#{controller_path}/#{action_name}"
  end

  def image_path_or_placeholder(model, image_field_name, thumb = nil)
    uploader = model.send(image_field_name)

    uploader = uploader.first if uploader.is_a?(Array)

    if uploader
      image = thumb ? uploader.send(thumb) : uploader

      if (image_path = image.try(:url))
        return image_path
      end
    end

    ImagePlaceholder.get_image_placeholder(model, image_field_name, thumb)
  end

  def no_index
    @_no_index = true
  end

  def no_index?
    @_no_index
  end
end
