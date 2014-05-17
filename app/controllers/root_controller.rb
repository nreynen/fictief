class RootController < ApplicationController
  before_filter :ensure_logged_in, :except => [:info, :home]
  
  def info
    
  end
  
  def home
    now = Time.now
    @can_order = !((now.strftime("%a") == "Sat" && now.hour > 6))
    @feeds = NewsFeed.last_five
  end
  
  def error
    
  end
end