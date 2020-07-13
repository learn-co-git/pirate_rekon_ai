Rails.application.routes.draw do

  root 'sessions#welcome'

  get '/signup' => 'users#new'
  post '/signup' => 'users#create'

  get '/signin' => 'sessions#new'
  post '/signin' => 'sessions#create'
  get '/logout' => 'sessions#destroy'
  get 'auth/auth0/callback' => 'auth0#callback'
  get 'auth/failure' => 'auth0#failure'
  get '/dashboard' => 'sessions#github'

  resources :reports, only: [:show] do
    resources :images, only: [:show, :index]
    resources :vehicles, only: [:show, :index]
    resources :users, only: [:show]
  end

  resources :images, only:
  [:index, :show, :new, :create, :edit, :update]

  resources :vehicles, only:
  [:index, :show, :new, :create, :edit, :update]

  resources :users, only:
  [:new, :show, :create, :update]

  resources :reports, only:
  [:index, :show, :new, :create, :edit, :update]

end
