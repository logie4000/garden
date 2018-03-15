Rails.application.routes.draw do
  resources :locations
  resources :calendars
  resources :seasons

  resources :users, path_names: { new: 'register' } do
    collection do
      get :change_password
      patch :update_password
      get :register 
      post :authenticate
      get :login
      get :list
      get :logout
      get :oauth
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

  namespace :api, defaults: {format: 'json'} do
    namespace :v1 do
      resources :crops
      resources :calendars
      resources :locations
      resources :users
    end
  end

  get '/about', to: redirect('crops/about')
  get '/login', to: redirect('users/login')
  root to: 'users#welcome'
end
