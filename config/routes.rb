Rails.application.routes.draw do
  resources :locations
  resources :calendars
  resources :crops
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :users, path_names: { new: 'register' } do
    collection do
      get :change_password
      patch :update_password
      get :register 
      post :authenticate
      get :login
      get :list
      get :logout
    end
  end

  resources :crops do
    collection do
      get :about
    end

    member do
      patch :add_location
    end
  end

  get '/about', to: redirect('crops/about')
  get '/login', to: redirect('users/login')
  root to: 'users#welcome'
end
