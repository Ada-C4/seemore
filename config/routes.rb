Rails.application.routes.draw do
  root "media#index"
  post "/auth/developer/callback", to: "sessions#create"

  get "marks/search/:provider", to: "marks#search", as: "search"
  post "search_redirect", to: "marks#redirect", as: 'create_search'
  get "search/results", to: "marks#results", as: "results"
end
