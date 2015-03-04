Rails.application.routes.draw do

  root to: redirect('/authors', status: 303)

  resources :users, only: [:new, :create]
  # resource :profile, only: [:edit]

  resources :authors, only: [:index, :show]
  resources :articles, only: [:index, :show]
  resources :blogs, only: [:index, :show]
  resources :forums, only: [:index, :show]
end
