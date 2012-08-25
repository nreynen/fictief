ActionController::Routing::Routes.draw do |map|
  map.root :controller => "user_sessions", :action => "new"
  
  map.resources :root, :only => [:index], :collection => {:home => :get, :error => :get, :login => [:get, :post]}
  
  map.resources :statics, :except => [:show, :new, :create]
  map.resources :users
  map.resources :categories
  map.resources :user_sessions, :except => [:edit]
  map.resources :items
  map.resources :orders
end
