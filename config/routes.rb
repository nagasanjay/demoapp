Rails.application.routes.draw do
  resources :foods
  resources :orders
  resources :food_services
  resources :services
  resources :users
  root 'users#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
