class UserSessionsController < ApplicationController
  before_filter :ensure_logged_in, :only => [:destroy]
  before_filter :ensure_logged_out, :only => [:new, :create]
  
  def index
    redirect_to(home_root_index_path)
  end
  
  def new
    @session = UserSession.new
  end
  
  def create
    @user = User.where(:login => params[:user][:login], :password => params[:user][:password]).first
    @session = UserSession.new(:user_id => @user.id) unless @user.nil?
    if @user && @session.save
      session[:user] = @session.id
      flash[:success] = "Hello #{@session.user.first_name}, you are logged in."
      url = session[:request_url]
      session[:request_url] = nil
      redirect_to(url || home_root_index_url)
    else
      redirect_to(new_user_session_path + "?error=1")
    end
  end

  def destroy
    UserSession.destroy(@session)
    session[:user] = @user = nil
    flash[:notice] = "You are logged out."
    session[:expiry_time] = 60.minutes.from_now
    redirect_to(home_root_index_url)
  end
end