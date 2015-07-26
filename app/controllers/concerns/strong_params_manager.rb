require "#{Rails.root}/app/controllers/param_permitters/base_param_permitter.rb"

module StrongParamsManager
  def permitted_params
    file_name = "#{controller_name}_param_permitter"
    #TODO почему-то добавление в autoload_paths не работает. разобраться почему
    require "#{Rails.root}/app/controllers/param_permitters/#{file_name}.rb"
    params.require(controller_name.singularize).permit(file_name.camelcase.constantize.actions[action_name])
  end
end