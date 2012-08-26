class ItemsController < ApplicationController
  before_filter :ensure_logged_in
  before_filter lambda { |x| x.ensure_is_admin([RIGHTS[:admin], RIGHTS[:bread_admin]])}
  
  def index
    @items = Item.paginate :page => params[:page], :order => "id", :per_page => 25
  end
  
  def show
    @item = Item.find(params[:id])
  end
  
  def new
    @item = Item.new
  end
  
  def create
    @item = Item.new(params[:item])

    if @item.save
      redirect_to(items_path, :flash => { :success => "Item was successfully created..." })
    else
      render :action => "new"
    end
  end
  
  def edit
    @item = Item.find(params[:id])
  end
  
  def update
    @item = Item.find(params[:id])

    if @item.update_attributes(params[:item])
      redirect_to(items_path, :flash => { :success => "Item was successfully updated..." })
    else
      render :action => "edit"
    end
  end

  def destroy
    @item = Item.find(params[:id])
    @item.destroy

    redirect_to(items_url, :flash => { :success => "Item was successfully destroyed..." })
  end
end