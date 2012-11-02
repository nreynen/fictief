class RootController < ApplicationController
  before_filter :ensure_logged_in, :except => [:info]
  
  def info
    @feeds = NewsFeed.last_five
  end
  
  def home
    
  end
  
  def error
    
  end
end