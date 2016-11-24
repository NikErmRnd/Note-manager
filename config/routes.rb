Rails.application.routes.draw do


  devise_for :users, :controllers => {registrations: 'registrations', omniauth_callbacks: "users/omniauth_callbacks" } do

  end

 # get 'auth/:provider/callback', to: 'sessions#create'
 # get 'auth/failure', to: redirect('/')
 # get 'signout', to: 'sessions#destroy', as: 'signout'

  get 'home/index'

  get 'persons/profile'

  root 'home#index'

  get 'persons/profile', as: 'user_root'

  resources :tags, only: [:show]

  resources :books do
    resources :notes
  end
end
