class Book::SeriesController < ApplicationController
  before_filter :ensure_logged_in
  before_filter lambda { |x| x.ensure_is_admin([RIGHTS[:admin], RIGHTS[:book_admin]])}
  
  def create
    @serie = Book::Serie.new(params[:book_serie].permit(:name, :author_id))
    
    if @serie.save
      redirect_to(book_series_index_path, :flash => { :success => "Serie was successfully created..." })
    else
      render :action => "new"
    end
  end
  
  def edit
    @serie = Book::Serie.find(params[:id])
  end
  
  def index
    @series = Book::Serie.paginate :page => params[:page], :order => "name", :per_page => 25
  end
  
  def new
    @serie = Book::Serie.new
  end
  
  def show
    @serie = Book::Serie.find(params[:id])
  end
  
  def update
    @serie = Book::Serie.find(params[:id])
    
    if @serie.update_attributes(params[:book_serie].permit(:name, :author_id))
      redirect_to(book_series_index_path, :flash => { :success => "Serie was successfully updated..." })
    else
      render :action => "edit"
    end
  end
end