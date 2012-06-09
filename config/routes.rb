ActionController::Routing::Routes.draw do |map|
  map.root :controller => "root", :action => "home"
  
  map.resources :root, :only => [:index], :collection => {:home => :get, :error => :get, :login => [:get, :post]}
  
  map.resources :statics, :except => [:show, :new, :create]
  map.resources :users
  map.resources :categories
  map.resources :items
  map.resources :orders
end
