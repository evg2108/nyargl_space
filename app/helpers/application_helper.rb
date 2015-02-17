module ApplicationHelper
  def current_asset_name
    @current_asset_name ||= "application/#{controller_name}/#{action_name}"
  end
end
