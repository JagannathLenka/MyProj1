MyProj1::Application.routes.draw do
  get  'login/aboutus'  => 'login#aboutus' 
  get  'login/contactus' => 'login#contactus'
  get  'login/landingpage' => 'login#landingpage'
  get  'userregister/thanks' => 'userregister#thanks'
  post 'locationmaintenance/upload/' => 'locationmaintenance#upload'
  post 'itemmastermaintenance/upload/' => 'itemmastermaintenance#upload'
  
  resources :warehouse, :bay, :position, :login, :locationerror, :locationmaintenance, :usermaintenance, :userregister,:userregistermaintenance, :posmaintenance, :levelmaintenance, :baysmaintenance, :aislemaintenance,
            :zonemaintenance, :warehousemaintenance, :slottingrecomaintenance, :itemmastermaintenance , :itemerror , :client


  
  # Custom route due to jqgrid non RESTful behaviour to allow editing the amount
  #post 'maintenance/update/' => 'maintenance#update'
  #get ':controller(/:action(/:id))'
  #post ':controller(/:action)'
  
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'
  root :to => 'maintenance#index'


  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
