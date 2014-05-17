MasterControl::Application.routes.draw do
  # namespace :book do |book|
    # resources :authors
    # resources :books
    # resources :genres
    # resources :languages
    # resources :publishers
    # resources :series
  # end
  namespace :bread do |bread|
    resources :bread_logs, :except => :destroy
    resources :categories
    resources :items
    resources :orders do
      match 'set_paid', :on => :collection, :via => :all
    end
    resources :weekly_orders
  end
  # namespace :dnu do |dnu|
    # resources :overviews, :only => [:index] do
      # match 'home', :on => :collection, :via => :all
      # match 'register', :on => :collection, :via => :all
      # match 'login', :on => :collection, :via => :all
    # end
  # end
  # namespace :workday do |workday|
    # resources :designations
    # resources :sequences
    # resources :workdays
  # end
  resources :news_feeds, :only => [:index, :new, :create]
  resources :reports, :only => [] do
    match 'bread_report', :on => :collection, :via => :all
  end
  resources :root, :only => [:index] do
    match 'error', :on => :collection, :via => :all
    match 'home', :on => :collection, :via => :all
    match 'info', :on => :collection, :via => :all
    match 'login', :on => :collection, :via => :all
  end
  resources :statics, :except => [:show, :new, :create]
  resources :user_rights, :only => [:index] do
    match 'delete_rights', :on => :collection, :via => :all
  end
  resources :user_sessions, :except => [:edit]
  resources :users do
    match 'change_password', :on => :collection, :via => :all
    match 'preferences', :on => :collection, :via => :all
  end
  
  root 'root#home'
end
