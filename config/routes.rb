Rails.application.routes.draw do
  root 'application#index'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  post '/signup', to: 'user#create'
  resources :user
end
