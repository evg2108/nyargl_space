module ApplicationHelper
  def current_asset_name
    @current_asset_name ||= "application/#{controller_name}/#{action_name}"
  end

  def present(object)
    presenter = "#{object.class.name}Presenter".constantize.new(object, self)
    block_given? ? yield(presenter) : presenter
  end
end
