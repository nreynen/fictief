class Dnu::OverviewsController < ApplicationController
  layout "dnu"
  
  def index
    render :action => :home
  end
  
  def home
    
  end
  
  def login
    
  end
  
  def register
    if params[:register] && params[:register] == "0"
      render :json => {:data => render_to_string(:partial => "register")} and return
    elsif params[:register] && params[:register] == "1"
      if params[:user]
        errors = []
        errors << "first_name" if /[0-9]/.match(params[:user][:first_name]) || params[:user][:first_name].length == 0
        errors << "last_name" if /[0-9]/.match(params[:user][:last_name]) || params[:user][:last_name].length == 0
        errors << "email" unless /^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}$/.match(params[:user][:email])
        errors << "login" unless /^[A-Za-z0-9_\s-]+$/.match(params[:user][:login])
        errors << "password" unless /^[A-Za-z0-9_-]+$/.match(params[:user][:password])
        errors << "password_confirmation" unless params[:user][:password] == params[:user][:password_confirmation]
        
        if errors.empty?
          attrs = params[:user]
          attrs.delete(:password_confirmation)
          user = Dnu::User.new(attrs)
          if false && user.save
            render :json => {:ok => "1"} and return
          else
            render :json => {:ok => "2", :fail => "Unknown error. Please try again or contact<br>the System Administrator if the issue persists."} and return
          end
        else
          render :json => {:ok => "0", :fail => errors} and return
        end
      else
        render :json => {:error => "Invalid data."} and return
      end
    else
      render :json => {:error => "Invalid request."} and return
    end
  end
end