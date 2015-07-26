class BaseParamPermitter
  class << self
    def actions
      @actions ||= HashWithIndifferentAccess.new { |hh,v| hh[v] = [] }
    end

    def create_params(*param_names)
      actions[:create] = param_names
    end

    def update_params(*param_names)
      actions[:update] = param_names
    end
  end
end