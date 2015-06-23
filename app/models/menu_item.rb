class MenuItem
  attr_accessor :controller_name, :action_name, :active_for_any_actions

  def initialize(controller, action, active_for_any_actions = false)
    self.controller_name = controller
    self.action_name = action
    self.active_for_any_actions = active_for_any_actions
  end

  def page_identifier
    { controller: "/#{controller_name}", action: action_name }
  end
end