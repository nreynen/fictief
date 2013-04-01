class Bread::OrdersController < ApplicationController
  before_filter :ensure_logged_in
  
  def index
    if (@user.has_rights_for?([RIGHTS[:admin], RIGHTS[:bread_admin]]) rescue false)
      @orders = Bread::Order.paginate :page => params[:page], :order => "id DESC", :per_page => 25
    else
      @orders = @user.orders.paginate :page => params[:page], :order => "id DESC", :per_page => 25
    end
    
    now = Time.now
    @can_order = !((now.strftime("%a") == "Sat" && now.hour > 6))
  end
  
  def show
    @order = Bread::Order.find(params[:id])
  end
  
  def new
    @order = Bread::Order.new
    @creating = true
  end
  
  def create
    @order = Bread::Order.new(params[:bread_order])
    order_string = ""
    y, m, d = params[:bread_order][:saturday_int].split("-")
    params[:bread_order][:saturday_int] = Date.new(y.to_i, m.to_i, d.to_i)
    params[:items].each_pair do |item_id, x|
      order_string << "#{item_id},#{x[:quantity]};" unless x[:quantity].blank?
    end
    @order.order = order_string
    
    if @order.save
      MasterMailer.deliver_bread_alert({
        :user => @user, 
        :subject => "Bread Notification: You have created an order!", 
        :message => "You have created a new order, containing #{@order.to_readable}.<br>If this is not the right order, or a mistake has been made, please edit it or contact us."
      })
      redirect_to(bread_orders_path, :flash => { :success => "Order was successfully created..." })
    else
      render :action => "new"
    end
  end
  
  def edit
    @order = Bread::Order.find(params[:id])
    @creating = false
  end
  
  def update
    @order = Bread::Order.find(params[:id])
    y, m, d = params[:bread_order][:saturday_int].split("-")
    params[:bread_order][:saturday_int] = Date.new(y.to_i, m.to_i, d.to_i)

    if @order.update_attributes(params[:bread_order])
      redirect_to(bread_orders_path, :flash => { :success => "Order was successfully updated..." })
    else
      render :action => "edit"
    end
  end

  def destroy
    @order = Bread::Order.find(params[:id])
    @order.destroy

    redirect_to(orders_url, :flash => { :success => "Order was successfully destroyed..." })
  end
  
  def set_paid
    if Bread::Order.update_all("paid = 1", "id = #{params[:id]}")
      redirect_to(bread_orders_path, :flash => { :success => "Order was successfully updated..." })
    else
      redirect_to(bread_orders_path, :flash => { :error => "Error occurred..." })
    end
  end
end