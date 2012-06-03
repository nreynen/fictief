ActionController::Routing::Routes.draw do |map|
  map.root :controller => "root", :action => "home"
  
  map.resources :root, :only => [:index], :collection => {:home => :get, :error => :get}
  
  map.resources :statics, :except => [:show]
#  map.resources :playnights, :except => [:edit, :destroy], :collection => {:add_playerplaynight => :post}
#  map.resources :playerplaynights, :except => [:edit, :destroy, :show]
end
