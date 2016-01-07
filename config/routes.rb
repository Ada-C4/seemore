Rails.application.routes.draw do
  root "media#index"
  post "/auth/developer/callback", to: "sessions#create"
end
