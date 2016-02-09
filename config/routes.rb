Rails.application.routes.draw do
  root "media#index"

  get '/login' => 'sessions#new'
  get '/logout' => 'sessions#destroy'

  get "marks/results", to: "marks#results", as: "results"

  resources :marks, only: [:index, :destroy]
  get "mark/info", to: "marks#show"

  get "/auth/:provider/callback", to: "sessions#create"

  post "/auth/developer/callback", to: "sessions#create"

  post "vimeo_subscribe", to: "marks#vimeo_subscribe", as: :vimeo_subscribe

  post "twitter_subscribe", to: "marks#twitter_subscribe", as: :twitter_subscribe

  get "feed/refresh", to: "media#refresh", as: "refresh_feed"
end
