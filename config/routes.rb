Rails.application.routes.draw do

  root to: redirect('/authors', status: 303)

  resource :session, only: [:new, :create, :destroy] do
    get 'once_login', on: :collection, as: :once_login
  end

  resources :users, only: [:new, :create]

  resource :user, only: [:update], as: :current_user

  resource :password_regeneration, only: [:show, :create]
  resource :profile, only: [] do
    get 'author_page', as: :author_page
    get 'products', as: :products
    get 'change_password', as: :change_password
  end

  resources :authors, only: [:index, :show]

  resource :author, only: [:update], as: :current_author do
    resources :photos, controller: :author_photos, only: [:create, :destroy]
  end

  resources :products, only: [:index, :show]

  resources :products, only: [:new, :create, :edit, :update, :destroy], path: '/profile/products', as: :controlled_product

  resources :blogs, only: [:index, :show]
  resources :forums, only: [:index, :show]
end
