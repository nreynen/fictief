ActionController::Routing::Routes.draw do |map|
  map.root :controller => "root", :action => "info"
  
  map.resources :root, :only => [:index], :collection => {:info => :get, :home => :get, :error => :get, :login => [:get, :post]}
  
  map.resources :statics, :except => [:show, :new, :create]
  map.resources :users, :collection => {:change_password => [:get, :post], :preferences => [:get, :post]}
  map.resources :user_rights, :only => [:index], :collection => {:delete_rights => [:get, :post]}
  map.resources :news_feeds, :only => [:index, :new, :create]
  map.resources :reports, :only => [], :collection => {:bread_report => [:get, :post]}
  map.resources :user_sessions, :except => [:edit]
  
  map.namespace :bread do |bread|
    bread.resources :bread_logs, :except => :destroy
    bread.resources :categories
    bread.resources :items
    bread.resources :orders, :collection => {:set_paid => [:get, :post]}
    bread.resources :weekly_orders
  end
  
  map.namespace :book do |book|
    book.resources :authors
    book.resources :publishers
    book.resources :genres
    book.resources :languages
    book.resources :series
    book.resources :books
  end
  
  map.namespace :dnu do |dnu|
    dnu.resources :overviews, :only => [:index], :collection => {:home => :get, :register => [:post, :get], :login => [:post, :get]}
  end
  
  map.namespace :workday do |work|
    work.resources :designations
    work.resources :workdays
    work.resources :sequences
  end
end
