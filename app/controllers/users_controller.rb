class UsersController < ApplicationController
  
  def index
    @users = User.paginate :page => params[:page], :order => "id", :per_page => 25
  end
  
  def show
    @user = User.find(params[:id])
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])

    if @user.save
      redirect_to(users_path, :flash => { :success => "User was successfully created..." })
    else
      render :action => "new"
    end
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])

    if @user.update_attributes(params[:user])
      redirect_to(users_path, :flash => { :success => "User was successfully updated..." })
    else
      render :action => "edit"
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy

    redirect_to(users_url, :flash => { :success => "User was successfully destroyed..." })
  end
end