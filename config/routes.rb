Rails.application.routes.draw do

  get 'home/index'

  devise_for :users, controllers: {registrations: 'registrations' }
  get 'persons/profile'

  root 'home#index'

  get 'persons/profile', as: 'user_root'

  resources :books do
    resources :notes
  end
end
