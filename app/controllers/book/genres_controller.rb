class Book::GenresController < ApplicationController
  before_filter :ensure_logged_in
  before_filter lambda { |x| x.ensure_is_admin([RIGHTS[:admin], RIGHTS[:book_admin]])}
  
  def create
    @genre = Book::Genre.new(params[:book_genre].permit(:name))
    
    if @genre.save
      redirect_to(book_genres_path, :flash => { :success => "Genre was successfully created..." })
    else
      render :action => "new"
    end
  end
  
  def edit
    @genre = Book::Genre.find(params[:id])
  end
  
  def index
    @genres = Book::Genre.paginate :page => params[:page], :order => "name", :per_page => 25
  end
  
  def new
    @genre = Book::Genre.new
  end
  
  def show
    @genre = Book::Genre.find(params[:id])
  end
  
  def update
    @genre = Book::Genre.find(params[:id])
    
    if @genre.update_attributes(params[:book_genre].permit(:name))
      redirect_to(book_genres_path, :flash => { :success => "Genre was successfully updated..." })
    else
      render :action => "edit"
    end
  end
end