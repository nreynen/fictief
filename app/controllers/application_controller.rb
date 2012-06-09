class ApplicationController < ActionController::Base
  
  helper :all
  protect_from_forgery
  
  #before_filter :ensure_logged_in
  
  before_filter :maintain_menu
  
  def maintain_menu
    @menu = [
      {
        :name => "BreadApp", :children => [
          { :name => "Overview", :url => "someUrl" }, 
          { :name => "Categories", :url => categories_path }, 
          { :name => "Orders", :url => orders_path }, 
          { :name => "Items", :url => items_path }
        ]
      }, 
      {
        :name => "CMS", :children => [
          { :name => "Statics", :url => statics_path }, 
          { :name => "Users", :url => users_path }
        ]
      }
    ]
    @menu << {
        :name => "Admin", :children => [
          { :name => "Spelers", :url => players_path },
          { :name => "Speelavonden", :url => playnights_path(:season => @current_season) }
        ]
    } if session[:is_admin]
  end
  
  private
  
  def ensure_logged_in
    unless @user
      flash[:error] = "aaa"#put("error_login")
      redirect_to(login_root_path)
    end
  end
end