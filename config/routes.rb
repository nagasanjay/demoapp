Rails.application.routes.draw do
  root 'application#index'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  post '/signup', to: 'user#create'
  get '/home', to: 'user#home'
  get '/service/:id', to: 'service#show'
  match '*path', via: :all, to: redirect('/404')
end
