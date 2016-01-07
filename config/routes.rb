Rails.application.routes.draw do
  root "media#index"

  get "marks/search/:provider", to: "marks#search", as: "search"

  get "marks/search/:provider/results", to: "marks#results", as: "results"

  get "/auth/:provider/callback", to: "sessions#create"
end
