Rails.application.routes.draw do
  root "media#index"
  get "/auth/:provider/callback", to: "sessions#create"
end
