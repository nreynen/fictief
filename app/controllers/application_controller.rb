class ApplicationController < ActionController::Base
  
  helper :all
  protect_from_forgery
  
  before_filter :maintain_session
  before_filter :maintain_menu
  
  def maintain_menu
    @menu = [
      {
        :name => "User", :children => [
          { :name => "Change Password", :url => change_password_users_path }, 
          { :name => "Preferences", :url => preferences_users_path }
        ]
      }
    ]
    # BookApp user menu
    @menu << {
      :name => "WorkCal", :children => [
        { :name => "Designations", :url => workday_designations_path }, 
        { :name => "Workdays", :url => workday_workdays_path }, 
        { :name => "Sequences", :url => workday_sequences_path }
      ]
    } if (@user.has_rights_for?([RIGHTS[:admin], RIGHTS[:workday_user]]) rescue false)
    # BookApp user menu
    @menu << {
      :name => "BookApp", :children => [
        { :name => "Authors", :url => book_authors_path }, 
        { :name => "Book", :url => book_books_path },
        { :name => "Publisher", :url => book_publishers_path }, 
        { :name => "Series", :url => book_series_index_path }, 
        { :name => "Language", :url => book_languages_path }, 
        { :name => "Genre", :url => book_genres_path }
      ]
    } if (@user.has_rights_for?([RIGHTS[:admin], RIGHTS[:book_admin]]) rescue false)
    # Bread user menu
    @menu << {
      :name => "BreadApp", :children => [
        { :name => "Orders", :url => bread_orders_path }
      ]
    } if (@user.has_rights_for?([RIGHTS[:admin], RIGHTS[:bread_user]]) rescue false)
    # Bread admin menu
    @menu << {
      :name => "BreadApp Admin", :children => [
        { :name => "Overview", :url => bread_report_reports_path }, 
        { :name => "Categories", :url => bread_categories_path }, 
        { :name => "Items", :url => bread_items_path }, 
        { :name => "Reporting", :url => bread_bread_logs_path }
      ]
    } if (@user.has_rights_for?([RIGHTS[:admin], RIGHTS[:bread_admin]]) rescue false)
    # Admin menu
    @menu << {
      :name => "Admin", :children => [
        { :name => "User Rights", :url => user_rights_path }, 
        { :name => "News Feeds", :url => news_feeds_path }
      ]
    } if (@user.has_rights_for?([RIGHTS[:admin]]) rescue false)
    # CMS menu
    @menu << {
      :name => "CMS", :children => [
        { :name => "Statics", :url => statics_path }, 
        { :name => "Users", :url => users_path }
      ]
    } if (@user.has_rights_for?([RIGHTS[:admin]]) rescue false)
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
  
  def ensure_is_admin(keys = [RIGHTS[:admin]])
    unless @user && @user.has_rights_for?(keys)
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