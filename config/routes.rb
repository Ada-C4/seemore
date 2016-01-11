Rails.application.routes.draw do

root 'users#show'
match "/auth/:provider/callback", to: "sessions#create", via: [:get, :post]

get '/vimeo_results' => 'users#vimeo_search', as: :vimeo_search
get '/twitter_results' => 'users#twitter_search', as: :twitter_search

get '/vimeo_results/users/:id' => 'users#vimeo_search_user', as: :vimeo_search_user
get '/twitter_results/:id' => 'users#twitter_search_user', as: :twitter_search_user

post '/vimeo_results/users/:id' => 'users#vimeo_subscribe', as: :vimeo_subscribe
post '/twitter_results/:id' => 'users#twitter_subscribe', as: :twitter_subscribe


get '/logout' => 'sessions#destroy'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
