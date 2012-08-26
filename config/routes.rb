ActionController::Routing::Routes.draw do |map|
  map.root :controller => "root", :action => "info"
  
  map.resources :root, :only => [:index], :collection => {:info => :get, :home => :get, :error => :get, :login => [:get, :post]}
  
  map.resources :statics, :except => [:show, :new, :create]
  map.resources :users
  map.resources :user_rights, :only => [:index], :collection => {:delete_rights => [:get, :post]}
  map.resources :reports, :only => [], :collection => {:bread_report => [:get, :post]}
  map.resources :categories
  map.resources :user_sessions, :except => [:edit]
  map.resources :items
  map.resources :orders
end
