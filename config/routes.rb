Rails.application.routes.draw do
  root "media#index"
  get "/auth/:provider/callback", to: "sessions#create"

  post "/auth/developer/callback", to: "sessions#create"

  post "vimeo_subscribe", to: "marks#vimeo_subscribe", as: :vimeo_subscribe
end
