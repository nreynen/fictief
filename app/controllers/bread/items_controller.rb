class Bread::ItemsController < ApplicationController
  before_filter :ensure_logged_in
  before_filter lambda { |x| x.ensure_is_admin([RIGHTS[:admin], RIGHTS[:bread_admin]])}
  
  def create
    @item = Bread::Item.new(params[:bread_item].permit(:name, :price, :category_id, :enabled))
    
    if @item.save
      redirect_to(bread_items_path, :flash => { :success => "Item was successfully created..." })
    else
      render :action => "new"
    end
  end
  
  def destroy
    @item = Bread::Item.find(params[:id])
    @item.destroy
    
    redirect_to(bread_items_path, :flash => { :success => "Item was successfully destroyed..." })
  end
  
  def edit
    @item = Bread::Item.find(params[:id])
  end
  
  def index
    @items = Bread::Item.paginate :page => params[:page], :order => "name", :per_page => 25
  end
  
  def new
    @item = Bread::Item.new
  end
  
  def show
    @item = Bread::Item.find(params[:id])
  end
  
  def update
    @item = Bread::Item.find(params[:id])
    
    if @item.update_attributes(params[:bread_item].permit(:name, :price, :category_id, :enabled))
      redirect_to(bread_items_path, :flash => { :success => "Item was successfully updated..." })
    else
      render :action => "edit"
    end
  end
end