class RootController < ApplicationController
  before_filter :ensure_logged_in, :except => [:info]
  
  def info
    
  end
  
  def home
    
  end
  
  def error
    
  end
end