Rails.application.routes.draw do

  root to: redirect('/authors', status: 303)

  resource :session, only: [:new, :create, :destroy] do
    get 'once_login', on: :collection, as: :once_login
  end

  resources :users, only: [:new, :create]

  resource :password_regeneration, only: [:show, :create]

  resources :authors, only: [:index, :show]

  resources :products, only: [:index, :show]

  resources :comments, only: [:create, :update]

  resources :blogs, only: [:index, :show]
  resources :forums, only: [:index, :show]

  namespace :profile do
    resource :password, only: [:edit, :update], path_names: { edit: :change }
    resource :author, only: [:show, :update] do
      resources :photos, controller: :author_photos, only: [:create, :destroy]
    end
    resources :products do
      resources :pictures, controller: :product_pictures, only: [:create, :destroy]
    end
  end
end
