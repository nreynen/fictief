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
  
  def preferences
    if (params[:pref][:action] == "make_year" rescue false)
      d, m, y = params[:pref][:data][:start].split("/").inject([]){|a, x| a << x.to_i; a}
      start_int = (Date.new(y, m, d) - Date.new(1970, 1, 1)).to_i
      cur_int = start_int
      start_seq = (@user.workday_sequences.last.seq.split(";").compact rescue [])
      cur_seq_position = 0
      
      while cur_seq_position < start_seq.length || cur_int < start_int + 365 do
        cur_seq_position = 0 if cur_seq_position == start_seq.length
        
        w = Workday::Workday.find(:first, :conditions => ["day = ? AND user_id = ?", cur_int, @user.id])
        if w.nil?
          ww = Workday::Workday.new({
            :user_id => @user.id, 
            :day => cur_int, 
            :designation_id => start_seq[cur_seq_position]
          })
          ww.save
        else
          w[:designation_id] = start_seq[cur_seq_position]
          w.save
        end
        
        cur_int += 1
        cur_seq_position += 1
      end unless start_seq.empty?
      
      render :text => "ok" and return
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
  
  def change_password
    if params[:user]
      if params[:user][:old_pwd] == @user.password && params[:user][:new_pwd].length > 7 && params[:user][:new_pwd] == params[:user][:rpt_pwd]
        @user.password = params[:user][:new_pwd]
        @user.save
        flash[:success] = "Password was changed"
      else
        flash[:error] = "Password was not changed due to an unexpected error"
      end
    end
  end
end