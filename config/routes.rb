Rails.application.routes.draw do
  root 'users#show'

  post "/auth/developer/callback", to: "sessions#create"
  get "/auth/:provider/callback", to: "sessions#create"
  get "/search" => "searches#search", as: :search
  delete "/logout" => "sessions#destroy", as: :logout
  get '/feed', to: "users#show", as: :feed

  resources :sessions, except: [:update]
  resources :creators
  
end
