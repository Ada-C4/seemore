Rails.application.routes.draw do

  root 'users#feed'

  match "/auth/:provider/callback" => "sessions#create", via: [:get, :post]
  get "/login" => "sessions#new", as: :login
  delete "/logout/"              => "sessions#destroy", as: :logout
  get "/search/"                => "creators#search"
  resources :users, only: [:show, :delete, :create, :update]


end
