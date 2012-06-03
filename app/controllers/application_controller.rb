class ApplicationController < ActionController::Base
  helper :all
  protect_from_forgery
  
  before_filter :maintain_menu
  
  def maintain_menu
    @menu = [
      {
        :name => "BreadApp", :children => [
          { :name => "Overview", :url => "someUrl" }
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
end