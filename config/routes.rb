Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get 'rooms/index'
  resources :rooms
  resources :users
  root 'rooms#index'
  
  resources :rooms do
    resources :messages
  end
  

  get '/signin', to: 'sessions#new'
  get '/signup', to: 'sessions#signup'
  post '/signin', to: 'sessions#create'
  delete '/signout', to: 'sessions#destroy'

  
end
