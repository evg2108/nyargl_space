# This concern module define memoized methods (using decent_exposure gem) for simple loading
# resource defined by controller name
#
# if you want use pagination for resources, you must set per_page parameter in controller, for example:
#
#   self.per_page = 10
#
# if defined decorator class for current resource, then resource will be automatically decorated
#
module SimpleResourceLoader
  extend ActiveSupport::Concern

  included do
    cattr_accessor :per_page

    expose!(resource_name) do
      single_resource
    end

    expose(resources_name) do
      plural_resources
    end

    expose(:page_num) do
      result = params[:page].to_i
      result <= 0 ? 1 : result
    end
  end

  class_methods do
    def resource_name; @resource_name ||= controller_name.singularize.to_sym end
    def resources_name; @resources_name ||= controller_name.to_sym end
    def resource_class; @resource_class ||= controller_name.classify.constantize end
    def decorator_class
      @decorator_class ||= "#{resource_name}_decorator".classify.safe_constantize
    end
  end

  private

  def get_id
    params[:id]
  end

  # TODO need to write a test
  def single_resource
    if get_id
      result = self.class.resource_class.find(get_id)
      result.assign_attributes(safe_params) if request.put? || request.patch?
      self.class.decorator_class ? result.decorate : result
    else
      # if try(:in_session_file_storage?) && (validated_model = try(:read_from_session_file_storage, self.class.resource_class))
      #   validated_model
      # else
        self.class.resource_class.new(safe_params)
      # end
    end
  end

  # TODO need to write a test
  def plural_resources
    result = self.class.resource_class.all
    result = policy_scope(result) if respond_to?(:policy_scope) # Pundit supporting
    per_page = self.class.per_page
    result = result.page(page_num).per(per_page) if per_page
    self.class.decorator_class ? result.decorate : result
  end

  # TODO need to write a test
  def safe_params
    resurce_name = self.class.resource_name
    params_method_name = "#{resurce_name}_params".to_sym
    if params[resurce_name]
      if respond_to?(params_method_name) || private_methods.include?(params_method_name)
        send(params_method_name)
      else
        raise ActiveModel::ForbiddenAttributesError, "Please, define the '#{params_method_name}' method in #{self.class.name}"
      end
    end
  end
end