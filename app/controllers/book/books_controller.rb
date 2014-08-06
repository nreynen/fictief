class Book::BooksController < ApplicationController
  before_filter :ensure_logged_in
  before_filter lambda { |x| x.ensure_is_admin([RIGHTS[:admin], RIGHTS[:book_admin]])}
  
  def create
    @book = Book::Book.new(params[:book_book].permit(:title, :author_id, :publisher_id, :isbn, :pages, :genre_id, :print_nr, :print_year, :language_id, :original_language_id, :serie_id, :serie_nr, :comment))
    
    if @book.save
      redirect_to(book_books_path, :flash => { :success => "Book was successfully created..." })
    else
      render :action => "new"
    end
  end
  
  def edit
    @book = Book::Book.find(params[:id])
  end
  
  def index
    @books = Book::Book.paginate :page => params[:page], :order => "title", :per_page => 25
  end
  
  def new
    @book = Book::Book.new
  end
  
  def show
    @book = Book::Book.find(params[:id])
  end
  
  def update
    @book = Book::Book.find(params[:id])
    
    if @book.update_attributes(params[:book_book].permit(:title, :author_id, :publisher_id, :isbn, :pages, :genre_id, :print_nr, :print_year, :language_id, :original_language_id, :serie_id, :serie_nr, :comment))
      redirect_to(book_books_path, :flash => { :success => "Book was successfully updated..." })
    else
      render :action => "edit"
    end
  end
end