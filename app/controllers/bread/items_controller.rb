class Bread::ItemsController < ApplicationController
  before_filter :ensure_logged_in
  before_filter lambda { |x| x.ensure_is_admin([RIGHTS[:admin], RIGHTS[:bread_admin]])}
  
  def index
    @items = Bread::Item.paginate :page => params[:page], :order => "id", :per_page => 25
  end
  
  def show
    @item = Bread::Item.find(params[:id])
  end
  
  def new
    @item = Bread::Item.new
  end
  
  def create
    @item = Bread::Item.new(params[:bread_item])

    if @item.save
      redirect_to(bread_items_path, :flash => { :success => "Item was successfully created..." })
    else
      render :action => "new"
    end
  end
  
  def edit
    @item = Bread::Item.find(params[:id])
  end
  
  def update
    @item = Bread::Item.find(params[:id])

    if @item.update_attributes(params[:bread_item])
      redirect_to(bread_items_path, :flash => { :success => "Item was successfully updated..." })
    else
      render :action => "edit"
    end
  end

  def destroy
    @item = Bread::Item.find(params[:id])
    @item.destroy

    redirect_to(items_url, :flash => { :success => "Item was successfully destroyed..." })
  end
end