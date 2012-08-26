class CategoriesController < ApplicationController
  before_filter :ensure_logged_in
  before_filter lambda { |x| x.ensure_is_admin([RIGHTS[:admin], RIGHTS[:bread_admin]])}
  
  def index
    @categories = Category.paginate :page => params[:page], :order => "id", :per_page => 25
  end
  
  def show
    @category = Category.find(params[:id])
  end
  
  def new
    @category = Category.new
  end
  
  def create
    @category = Category.new(params[:category])

    if @category.save
      redirect_to(categories_path, :flash => { :success => "Category was successfully created..." })
    else
      render :action => "new"
    end
  end
  
  def edit
    @category = Category.find(params[:id])
  end
  
  def update
    @category = Category.find(params[:id])

    if @category.update_attributes(params[:category])
      redirect_to(categories_path, :flash => { :success => "Category was successfully updated..." })
    else
      render :action => "edit"
    end
  end

  def destroy
    @category = Category.find(params[:id])
    @category.destroy

    redirect_to(categories_url, :flash => { :success => "Category was successfully destroyed..." })
  end
end