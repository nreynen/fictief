ActionController::Routing::Routes.draw do |map|
  map.root :controller => "root", :action => "home"
  
  map.resources :root, :only => [:index], :collection => {:home => :get, :error => :get}
  
  map.resources :statics, :except => [:show, :new, :create]
  map.resources :users
  map.resources :categories
  map.resources :items
end
