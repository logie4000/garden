Rails.application.routes.draw do
  resources :locations
  resources :calendars

  resources :users, path_names: { new: 'register' } do
    collection do
      get :change_password
      patch :update_password
      get :register 
      post :authenticate
      get :login
      get :list
      get :logout
      get :authorize
    end
  end

  resources :crops do
    collection do
      get :about
      get :graphical
    end

    member do
      patch :add_location
    end
  end

  get '/about', to: redirect('crops/about')
  get '/login', to: redirect('users/login')
  root to: 'users#welcome'
end
