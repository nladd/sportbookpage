ActionController::Routing::Routes.draw do |map|

  map.resources :users

  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller
  
  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  map.root :controller => "login"

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing the them or commenting them out if you're using named routes and resources.

  map.home '/home/', :controller => 'users', :action => 'index'
  map.login '/login/', :controller => 'login', :action => 'index'
  
  map.search '/search/', :controller => 'users', :action => 'friends_search'
  map.drop '/drop/', :controller => 'draggables', :action => 'route_action'
  
  map.register '/register', :controller => 'user_preferences', :action => 'create_sports_and_teams'
  map.connect '/register', :controller => 'user_preferences', :action => 'create_sports_and_teams'
  map.connect '/register/2', :controller => 'user_preferences', :action => 'create_profile'
  map.connect '/register/3', :controller => 'user_preferences', :action => 'create_account'
  
  map.connect '/edit/sports_and_teams', :controller => 'user_preferences', :action => 'edit_sports_and_teams'
  map.connect '/edit/profile', :controller => 'user_preferences', :action => 'edit_profile'
  map.connect '/edit/account', :controller => 'user_preferences', :action => 'edit_account'
 
  map.connect '/challenge', :controller => 'users', :action => 'create_challenge'


 
  map.connect '/fanatic/:name', :controller => 'users', :action => 'friend_home'
  map.connect '/player/:id', :controller => 'player', :action => 'index'
  map.connect '/team/:id', :controller => 'team', :action => 'index'
  map.connect 'league/:league_id/conference/:id', :controller => 'conference', :action => 'index'
  map.connect '/league/:id', :controller => 'league', :action => 'index'
  
  # Default/fall-back value
  map.connect ':controller/:action'
  
end
