class Book::SeriesController < ApplicationController
  
  def index
    @series = Book::Serie.all_sorted_with_author.paginate :page => params[:page], :order => "name ASC", :per_page => 25
    @count = @series.length
  end
  
  def show
    @serie = Book::Serie.find(params[:id])
  end

  def new
    @serie = Book::Serie.new
    @authors = Book::Author.all_sorted
  end

  def edit
    @serie = Book::Serie.find(params[:id])
    @authors = Book::Author.all_sorted
  end

  def create
    @serie = Book::Serie.new(params[:book_serie])

    if @serie.save
      redirect_to(book_series_index_path, :flash => { :success => "Serie was successfully created..." })
    else
      @authors = Book::Author.all_sorted
      render :action => "new"
    end
  end

  def update
    @serie = Book::Serie.find(params[:id])

    if @serie.update_attributes(params[:book_serie])
      redirect_to(book_series_index_path, :flash => { :success => "Serie was successfully updated..." })
    else
      @authors = Book::Author.all_sorted
      render :action => "edit"
    end
  end

  def destroy
    @serie = Book::Serie.find(params[:id])
    @serie.destroy

    redirect_to(book_series_index_url, :flash => { :success => "Serie was successfully destroyed..." })
  end
end