Rails.application.routes.draw do
  devise_for :users, :controllers => { :registrations => "users/registrations" }

  #Synchron babe
  resources :posts
  root 'feed#index'
  post '/' => 'posts#create'
  get 'users/:username' => 'users#display_user', as: 'profile'
  get 'users/:username/bookmarks' => 'users#bookmarks#', as: 'bookmarks'

  get '/search' => 'search#search'

  # AJAX babe
  get 'users/follow/:id' => 'users#follow' 
  get 'users/unfollow/:id' => 'users#unfollow'

  get '/feed/:id_last_post' => 'feed#get_feed'
  get '/user/:username/:id_last_post' => 'users#get_feed_user'
  get '/user/bookmarks/:username/:id_last_post' => 'users#get_bookmarks_user'
  
  get 'posts/add_bookmark/:id' => 'posts#add_bookmark' 
  get 'posts/remove_bookmark/:id' => 'posts#remove_bookmark'

  get 'posts/add_repost/:id' => 'posts#add_repost' 
  get 'posts/remove_repost/:id' => 'posts#remove_repost'

  get 'suggest/suggestusers' => 'feed#get_suggest_users'
  get 'suggest/suggestposts' => 'feed#get_suggest_posts'

  get '/search/by_hash/:q/:id' => 'search#get_posts_with_hashtags_for_search'
  get '/search/by_posts/:q/:id' => 'search#get_posts_for_search'
  get '/search/by_users/:q/:id' => 'search#get_users_for_search'


  

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
