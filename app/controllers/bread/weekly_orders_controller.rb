class Bread::WeeklyOrdersController < ApplicationController
  before_filter :ensure_logged_in
  
  def create
    @order = Bread::WeeklyOrder.new(params[:bread_weekly_order].permit(:order, :user_id))
    order_string = []
    params[:items].each_pair do |item_id, x|
      order_string << "#{item_id},#{x}" unless x.blank? || x.to_i == 0
    end
    @order.order = order_string.join(";")
    
    if order_string.length > 0 && @order.save
      MasterMailer.bread_alert({
        :user => @user, 
        :subject => "Bread Notification: You have created a weekly order!", 
        :message => "You have created a new weekly order, containing #{@order.to_readable}.<br>If this is not yours, or a mistake has been made, please edit it or contact us."
      }).deliver
      redirect_to(bread_weekly_orders_path, :flash => { :success => "Order was successfully created..." })
    else
      render :action => "new"
    end
  end
  
  def destroy
    @order = Bread::WeeklyOrder.find(params[:id])
    @order.destroy
    
    redirect_to(bread_weekly_orders_url, :flash => { :success => "Weekly Order was successfully destroyed..." })
  end
  
  def edit
    @order = Bread::WeeklyOrder.find(params[:id])
    @creating = false
  end
  
  def index
    @order = Bread::WeeklyOrder.find(:first, :conditions => ["user_id = ?", @user.id])
    @can_create = @order.nil?
  end
  
  def new
    @order = Bread::WeeklyOrder.new
    @creating = true
  end
  
  def update
    @order = Bread::WeeklyOrder.find(params[:id])
    order_string = []
    params[:items].each_pair do |item_id, x|
      order_string << "#{item_id},#{x}" unless x.blank? || x.to_i == 0
    end
    @order.order = order_string.join(";")
    
    if @order.update_attributes(params[:bread_weekly_order].permit(:order, :user_id))
      redirect_to(bread_weekly_orders_path, :flash => { :success => "Weekly Order was successfully updated..." })
    else
      render :action => "edit"
    end
  end
end