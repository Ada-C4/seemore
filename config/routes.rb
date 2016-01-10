Rails.application.routes.draw do
  root 'welcome#index'

  # testing only! if Ricky forgets to remove this, kindly remind them
  get '/testing' => 'media#testing'

  # users route
  get '/users/:id' => 'users#show', as: :user # gets user's account page

  # handles routes
  resources :handles, :only => [:index, :show] # show a twitter handle's feed
  get 'search/:query' => 'handles#search', :as => 'search' # search all posts
  get '/search' => 'handles#search_vimeo', :as => 'search_vimeo' # search vimeo

  # media routes
  post 'handles/:id' => 'handles#add' # add twitter account to user's feed
  # KD note: may not need both this route and the above route:
  post '/subscribe' => 'handles#subscribe', :as => 'subscribe' # creates handle object if it doesn't exits, associates handle with user
  delete 'users/:user_id/handles/:id' => 'handles#remove' # delete twitter account from user's feed

  # sessions routes
  get "/auth/:provider/callback", to: "sessions#create"
  delete "/logout", to: 'sessions#destroy', as: :logout

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
