module ApplicationHelper
  def current_asset_name
    @current_asset_name ||= "application/#{controller_name}/#{action_name}"
  end

  def image_path_or_placeholder(model, thumb)
    return model.avatar.url if model.avatar.url
    model_name = model.class.model_name.plural

    @_placeholder_files_count ||= {}
    @_placeholder_files_count[model_name] ||= {}
    @_placeholder_files_count[model_name][thumb] ||= Dir[Rails.root + "public#{Rails.application.config.image_placeholders_path}/#{model_name}/#{thumb}/*.jpg"].length

    @_placeholder_files ||= {}
    @_placeholder_files[model_name] ||= {}
    unless @_placeholder_files[model_name][thumb]
      @_placeholder_files[model_name][thumb] = (1..@_placeholder_files_count[model_name][thumb]).map { |index| "#{Rails.application.config.image_placeholders_path}/#{model_name}/#{thumb}/#{index}.jpg" }
    end

    @_placeholder_files[model_name][thumb][model.id.modulo(@_placeholder_files_count[model_name][thumb])]
  end

  def no_index
    @_no_index = true
  end

  def no_index?
    @_no_index
  end
end
