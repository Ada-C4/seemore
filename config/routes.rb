Rails.application.routes.draw do
  root 'users#show'

  post "/auth/developer/callback", to: "sessions#create"
  get "/auth/:provider/callback", to: "sessions#create"
  get "/search" => "searches#search", as: :search
  delete "/logout" => "sessions#destroy", as: :logout
  get '/feed', to: "users#show", as: :feed
  post '/follow', to:"creators#follow", as: :follow
  post '/unfollow', to:"creators#unfollow", as: :unfollow

  resources :sessions, except: [:update, :destroy]
  resources :creators

end
