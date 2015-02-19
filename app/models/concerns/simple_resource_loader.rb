# This concern module define memoized methods (using decent_exposure gem) for simple loading
# resource defined by controller name
#
module SimpleResourceLoader
  extend ActiveSupport::Concern

  included do
    expose(resource_name)
    expose(resources_name)
  end

  class_methods do
    def resource_name; controller_name.singularize.to_sym end
    def resources_name; controller_name.to_sym end
  end
end