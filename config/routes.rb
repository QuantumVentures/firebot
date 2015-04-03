Rails.application.routes.draw do
  root "pages#index"

  # Sessions
  get "login"  => "sessions#new",     as: :login
  get "logout" => "sessions#destroy", as: :logout

  # Users
  get "sign-up" => "users#new", as: :new_user

  resources :sessions, only: %i(create destroy)
  resources :users, only: %i(create edit update)
end
