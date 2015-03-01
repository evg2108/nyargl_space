Rails.application do
  config.autoload_paths += %W(#{config.root}/app/presenters)
end