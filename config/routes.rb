Rails.application.routes.draw do
  root "home#index"

  # Sessions
  get "login"  => "sessions#login",  as: :login
  get "logout" => "sessions#logout", as: :logout

  # Users
  get "sign-up" => "users#new", as: :new_user

  resources :backend_apps, path: "apps" do
    resources :components, controller: :backend_app_components,
                           only: %i(create destroy index new show)
    resources :features, only: %i(create new)
    resources :models do
      member do
        post :remove_column, path: "remove-column"
      end
    end

    member do
      get :documentation
      get :status
    end
  end
  resources :sessions, only: %i(create)
  resources :users,    only: %i(create edit update)
end
