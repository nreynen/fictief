class UsersController < ApplicationController
  before_filter :ensure_logged_in
  
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
    params[:rights].each do |right|
      params[:user][:user_rights] ||= []
      params[:user][:user_rights] << UserRight.create({:user_id => @user.id, :rights_key => right})
    end if params[:rights]

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
    params[:rights].each do |right|
      params[:user][:user_rights] ||= []
      params[:user][:user_rights] << UserRight.create({:user_id => @user.id, :rights_key => right})
    end if params[:rights]

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