class OrdersController < ApplicationController
  
  def index
    @orders = Order.paginate :page => params[:page], :order => "id", :per_page => 25
  end
  
  def show
    @order = Order.find(params[:id])
  end
  
  def new
    @order = Order.new
    @creating = true
  end
  
  def create
    @order = Order.new(params[:order])
    order_string = ""
    params[:items].each_pair do |item_id, x|
      order_string << "#{item_id},#{x[:quantity]};" unless x[:quantity].blank?
    end
    @order.order = order_string
    
    if @order.save
      redirect_to(orders_path, :flash => { :success => "Order was successfully created..." })
    else
      render :action => "new"
    end
  end
  
  def edit
    @order = Order.find(params[:id])
    @creating = false
  end
  
  def update
    @order = Order.find(params[:id])

    if @order.update_attributes(params[:order])
      redirect_to(orders_path, :flash => { :success => "Order was successfully updated..." })
    else
      render :action => "edit"
    end
  end

  def destroy
    @order = Order.find(params[:id])
    @order.destroy

    redirect_to(orders_url, :flash => { :success => "Order was successfully destroyed..." })
  end
end