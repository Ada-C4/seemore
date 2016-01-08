Rails.application.routes.draw do
  root "media#index"

  get "marks/search/:provider", to: "marks#search", as: "search"

  get "marks/search/:provider/results", to: "marks#results", as: "results"

  get "marks", to: "marks#index"

  get "/auth/:provider/callback", to: "sessions#create"

  post "/auth/developer/callback", provider: "developer"

  post "vimeo_subscribe", to: "marks#vimeo_subscribe", as: :vimeo_subscribe
end
