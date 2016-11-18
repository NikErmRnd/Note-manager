Rails.application.routes.draw do

  #devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  devise_for :users, :controllers => {registrations: 'registrations', omniauth_callbacks: "users/omniauth_callbacks" }

  #resources :users, :only => [:index, :destroy]
 # root :to => 'users#index'

  namespace :users do
    get 'omniauth_callbacks/facebook'
  end

  namespace :users do
    get 'omniauth_callbacks/vkontakte'
  end

  get 'home/index'

 # devise_for :users, controllers: {registrations: 'registrations' }
  get 'persons/profile'

  root 'home#index'

  get 'persons/profile', as: 'user_root'

  resources :tags, only: [:show]

  resources :books do
    resources :notes
  end
end
