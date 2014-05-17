class Bread::BreadLogsController < ApplicationController
  before_filter :ensure_logged_in
  
  def create
    @bread_log = Bread::BreadLog.new(params[:bread_bread_log].permit(:cat_id, :event_date, :price))
    d, m, y = params[:log_date].split("/")
    @bread_log.event_date = Date.new(y.to_i, m.to_i, d.to_i)
    
    if @bread_log.save
      redirect_to(bread_bread_logs_path, :flash => { :success => "Log was successfully created..." })
    else
      render :action => "new"
    end
  end
  
  def edit
    @bread_log = Bread::BreadLog.find(params[:id])
  end
  
  def index
    @bread_logs = Bread::BreadLog.paginate :page => params[:page], :order => "id", :per_page => 25
  end
  
  def new
    @bread_log = Bread::BreadLog.new
  end
  
  def update
    @bread_log = Bread::BreadLog.find(params[:id])
    d, m, y = params[:log_date].split("/")
    @bread_log.event_date = Date.new(y.to_i, m.to_i, d.to_i)
    
    if @bread_log.update_attributes(params[:bread_bread_log].permit(:cat_id, :event_date, :price))
      redirect_to(bread_bread_logs_path, :flash => { :success => "Log was successfully updated..." })
    else
      render :action => "edit"
    end
  end
end