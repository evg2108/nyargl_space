Rails.application.routes.draw do

  root to: redirect('/authors', status: 303)

  resource :session, only: [:create, :destroy] do
    get 'once_login', on: :collection, as: :once_login
  end
  resources :users, only: [:new, :create, :update]
  resource :password_regeneration, only: [:show, :create]
  resource :profile, only: [] do
    get 'author_page', as: :author_page
    get 'change_password', as: :change_password
  end

  resources :authors, only: [:index, :show, :update]

  resources :articles, only: [:index, :show]
  resources :blogs, only: [:index, :show]
  resources :forums, only: [:index, :show]
end
