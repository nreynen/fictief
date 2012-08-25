class UserSessionsController < ApplicationController
  #before_filter :ensure_admin_login, :only => [:destroy]
  #before_filter :ensure_admin_logout, :only => [:new, :create]
  #before_filter :ensure_logout
  
  def index
    redirect_to(new_user_session_path)
  end
  
  def new
    @session = UserSession.new
  end
  
  def create
    @user = User.find_by_login_and_password(params[:user][:login], params[:user][:password])
    @session = UserSession.new(:user_id => @user.id) unless @user.nil?
    if @user && @session.save
      session[:user] = @session.id
      flash[:success] = "Hello #{@session.user.first_name}, you are logged in."
      url = session[:request_url]
      session[:request_url] = nil
      redirect_to(url || home_root_url)
    else
      flash[:error] = "Error while logging in."
      render(:action => 'new')
    end
  end

  def destroy
    UserSession.destroy(@session)
    session[:admin] = @user = nil
    flash[:notice] = "You are logged out."
    session[:expiry_time] = 60.minutes.from_now
    redirect_to(root_url)
  end
end