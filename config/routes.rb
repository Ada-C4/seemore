Rails.application.routes.draw do
  root 'users#show'
  get "/auth/:provider/callback", to: "sessions#create"
  resources :sessions, except: [:update]
  resources :creators
  get "/search" => "searches#search", as: :search

  
end
