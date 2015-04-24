Rails.application.routes.draw do
  root "home#index"

  # Sessions
  get "login"  => "sessions#login",  as: :login
  get "logout" => "sessions#logout", as: :logout

  # Users
  get "sign-up" => "users#new", as: :new_user

  resources :backend_apps, path: "apps" do
    resources :components, only: %i() do
      collection do
        get :app_index, as: :index, path: "/"
        get :app_new, as: :new, path: "/new"
      end
      member do
        get :app_show, as: "", path: ""
      end
    end
    resources :compositions, only: %i(create) do
      collection do
        delete :destroy
      end
    end
    resources :features, only: %i(create new)
    resources :models do
      member do
        post :remove_column, path: "remove-column"
      end
    end
    member do
      get :status
    end
  end
  resources :sessions, only: %i(create)
  resources :users,    only: %i(create edit update)
end
