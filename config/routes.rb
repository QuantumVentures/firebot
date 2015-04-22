Rails.application.routes.draw do
  root "pages#index"

  # Sessions
  get "login"  => "sessions#login",  as: :login
  get "logout" => "sessions#logout", as: :logout

  # Users
  get "sign-up" => "users#new", as: :new_user

  resources :backend_apps, path: "apps" do
    resources :features, only: %i(create new)
    resources :models, only: %i(create index new)
    member do
      get :status
    end
  end
  resources :sessions, only: %i(create)
  resources :users,    only: %i(create edit update)
end
