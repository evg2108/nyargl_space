module StrongParamsManager
  def permitted_params
    permission_class = "#{self.class.name.sub('Controller', '')}Permission".camelcase.constantize
    params.require(permission_class.resource_name || controller_name.singularize).permit(permission_class.actions[action_name])
  end
end