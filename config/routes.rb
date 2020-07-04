Rails.application.routes.draw do

  root 'sessions#welcome'

  get '/signup' => 'users#new'
  post '/signup' => 'users#create'
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy'
  get '/auth/:provider/callback' => 'sessions#github'

  resources :users
  resources :images
  resources :vehicles
  resources :reports
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
