class Bread::OrdersController < ApplicationController
  before_filter :ensure_logged_in
  
  def create
    order_string = []
    y, m, d = params[:bread_order][:saturday_int].split("-")
    params[:bread_order][:saturday_int] = Date.new(y.to_i, m.to_i, d.to_i)
    params[:items].each_pair do |item_id, x|
      order_string << "#{item_id},#{x}" unless x.blank? || x.to_i == 0
    end
    @order = Bread::Order.new(params[:bread_order].permit(:saturday_int, :order, :user_id))
    @order.order = order_string.join(";")
    
    if order_string.length > 0 && @order.save
      # MasterMailer.bread_alert({
        # :user => @user, 
        # :subject => "Bread Notification: You have created an order!", 
        # :message => "You have created a new order, containing #{@order.to_readable}.<br>If this is not the right order, or a mistake has been made, please edit it or contact us."
      # }).deliver
      redirect_to(bread_orders_path, :flash => { :success => "Order was successfully created... Mail could not be sent!" })
    else
      render :action => "new"
    end
  end
  
  def destroy
    @order = Bread::Order.find(params[:id])
    @order.destroy
    
    redirect_to(bread_orders_url, :flash => { :success => "Order was successfully destroyed..." })
  end
  
  def edit
    @order = Bread::Order.find(params[:id])
    @creating = false
  end
  
  def index
    if (@user.has_rights_for?([RIGHTS[:admin], RIGHTS[:bread_admin]]) rescue false)
      @orders = Bread::Order.paginate :page => params[:page], :order => "id DESC", :per_page => 10
    else
      @orders = @user.orders.paginate :page => params[:page], :order => "id DESC", :per_page => 10
    end
    
    now = Time.now
    @can_order = !((now.strftime("%a") == "Sat" && now.hour > 6))
  end
  
  def new
    @order = Bread::Order.new
    @creating = true
  end
  
  def set_paid
    if Bread::Order.update_all("paid = 1", "id = #{params[:id]}")
      redirect_to(bread_orders_path, :flash => { :success => "Order was successfully updated..." })
    else
      redirect_to(bread_orders_path, :flash => { :error => "Error occurred..." })
    end
  end
  
  def show
    @order = Bread::Order.find(params[:id])
    @total = 0.0
    @quantities = []
    @quantities = @order.order.split(";").inject({}) do |h, x| 
      item = x.split(",")
      bread_item = Bread::Item.find(item[0])
      price_for_items = item[1].to_f * bread_item.price.to_f
      @total = @total + price_for_items
      
      h[item[0]] = [bread_item.name, item[1], price_for_items]
      h
    end.sort{|a, b| a[1][1] <=> b[1][1]} unless @order.order.blank?
  end
  
  def update
    @order = Bread::Order.find(params[:id])
    y, m, d = params[:bread_order][:saturday_int].split("-")
    params[:bread_order][:saturday_int] = Date.new(y.to_i, m.to_i, d.to_i)
    order_string = []
    params[:items].each_pair do |item_id, x|
      order_string << "#{item_id},#{x}" unless x.blank? || x.to_i == 0
    end
    @order.order = order_string.join(";")
    
    if @order.update_attributes(params[:bread_order].permit(:saturday_int, :order, :user_id))
      redirect_to(bread_orders_path, :flash => { :success => "Order was successfully updated..." })
    else
      render :action => "edit"
    end
  end
end