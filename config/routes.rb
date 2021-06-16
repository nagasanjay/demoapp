Rails.application.routes.draw do
  root 'application#index'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  post '/signup', to: 'user#create'
  put '/user', to: 'user#update'
  get '/home', to: 'user#home'
  get '/changehome', to: 'user#changeHome'
  get '/service/:id', to: 'service#show'
  post '/service', to: 'service#create'
  post '/order/:service', to: 'order#create'
  post '/food/:service_id', to: 'food#create'
  post '/stay/:service_id', to: 'stay#create'
  get '/search', to: 'service#search'
  post '/deliver/:order_id', to: 'order#deliver'
  post '/checkin/:order_id', to: 'order#checkin'
  post '/checkout/:order_id', to: 'order#checkout'
  match '*path', via: :all, to: redirect('/404')
end
