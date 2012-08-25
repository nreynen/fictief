class UserRightsController < ApplicationController
  before_filter :ensure_logged_in
  before_filter :ensure_is_admin
  
  def index
    @rights = UserRight.paginate :page => params[:page], :order => "rights_key", :per_page => 25
  end
  
  def new
    
  end
  
  def create
    
  end
  
  def edit
    
  end
  
  def update
    
  end

  def delete_rights
    
  end
end