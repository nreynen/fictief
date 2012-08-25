class ApplicationController < ActionController::Base
  
  helper :all
  protect_from_forgery
  
  before_filter :maintain_menu
  before_filter :maintain_session
  
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
      if @session = UserSession.find(session[:user])
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
end