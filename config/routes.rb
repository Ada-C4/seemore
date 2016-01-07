Rails.application.routes.draw do

  get 'users/show'

  get 'users/feed'

  get 'users/delete'

  get 'users/create'

  root 'users#feed'
  get "/auth/:provider/callback" => "sessions#create"
  delete "/logout/"              => "sessions#destroy", as: :logout
  get "/search/"                => "creators#search"
  resources :users, only: [:show, :delete, :create]

end
