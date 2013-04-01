class Bread::CategoriesController < ApplicationController
  before_filter :ensure_logged_in
  before_filter lambda { |x| x.ensure_is_admin([RIGHTS[:admin], RIGHTS[:bread_admin]])}
  
  def index
    @categories = Bread::Category.paginate :page => params[:page], :order => "id", :per_page => 25
  end
  
  def show
    @category = Bread::Category.find(params[:id])
  end
  
  def new
    @category = Bread::Category.new
  end
  
  def create
    @category = Bread::Category.new(params[:bread_category])

    if @category.save
      redirect_to(bread_categories_path, :flash => { :success => "Category was successfully created..." })
    else
      render :action => "new"
    end
  end
  
  def edit
    @category = Bread::Category.find(params[:id])
  end
  
  def update
    @category = Bread::Category.find(params[:id])

    if @category.update_attributes(params[:bread_category])
      redirect_to(bread_categories_path, :flash => { :success => "Category was successfully updated..." })
    else
      render :action => "edit"
    end
  end

  def destroy
    @category = Bread::Category.find(params[:id])
    @category.destroy

    redirect_to(categories_url, :flash => { :success => "Category was successfully destroyed..." })
  end
end