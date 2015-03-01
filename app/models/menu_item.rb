class MenuItem
  attr_accessor :slug, :controller_name, :action_name

  def initialize(slug, controller, action)
    self.slug = slug
    self.controller_name = controller
    self.action_name = action
  end
end