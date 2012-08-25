class ApplicationController < ActionController::Base
  
  helper :all
  protect_from_forgery
  
  before_filter :maintain_session
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
          { :name => "User Rights", :url => user_rights_path },
          { :name => "Bla", :url => "someUrl" }
        ]
    } if (@user.has_rights_for(RIGHTS[:admin]) rescue false)
  end
  
  def js_map(attributes)
    mapping = ["<script type='text/javascript'>"]
    attributes.each do |x|
      mapping << %Q{var #{x[0].to_s} = "#{@template.escape_javascript(x[1])}";}
    end
    mapping << "</script>"
    mapping.join
  end
  
  def maintain_session
    if session[:user]
      @session = UserSession.find(session[:user]) rescue nil
      if @session
        @user = @session.user
      else
        session[:user] = nil
        redirect_to(root_url)
      end
    end
  end
  
  def ensure_logged_in
    unless @user
      flash[:error] = @template.put("error_login")
      redirect_to(new_user_session_path)
    end
  end
  
  def ensure_is_admin
    unless @user && @user.has_rights_for(RIGHTS[:admin])
      flash[:error] = @template.put("rights_not_enough")
      redirect_to(home_root_path)
    end
  end
  
  def ensure_logged_out
    if @user
      flash[:error] = "You must logout first"
      redirect_to(home_root_url)
    end
  end
end