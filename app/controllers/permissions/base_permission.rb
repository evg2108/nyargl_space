class BasePermission
  class << self
    def actions
      @actions ||= HashWithIndifferentAccess.new { |hash,val| hash[val] = [] }
    end

    def create_params(*param_names)
      actions[:create] = param_names
    end

    def update_params(*param_names)
      actions[:update] = param_names
    end

    def resource_name=(name)
      @resource_name ||= name
    end

    def resource_name
      @resource_name
    end
  end
end