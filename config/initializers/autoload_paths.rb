Rails.application do
  config.autoload_paths += %W(#{config.root}/app/presenters #{config.root}/app/validators #{config.root}/app/controllers/param_permitters)
end