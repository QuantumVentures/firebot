Rails.application.routes.draw do
  root "pages#index"

  # Sessions
  get "login" => "sessions#new", as: :new_session

  # Users
  get "sign-up" => "users#new", as: :new_user

  resources :users, only: %i(create edit update)
end
