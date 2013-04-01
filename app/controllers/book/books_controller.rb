class Book::BooksController < ApplicationController
  
  def index
    @books = Book::Book.paginate :page => params[:page], :order => "title ASC", :per_page => 25
    @count = @books.length
  end
  
  def show
    @book = Book::Book.find(params[:id])
  end

  def new
    @book = Book::Book.new
    @authors = Book::Author.all_sorted
    @publishers = Book::Publisher.all_sorted
    @genres = Book::Genre.all_sorted
    @series = Book::Serie.all_sorted_with_author
    @languages = Book::Language.all_sorted
  end

  def edit
    @book = Book::Book.find(params[:id])
    @authors = Book::Author.all_sorted
    @publishers = Book::Publisher.all_sorted
    @genres = Book::Genre.all_sorted
    @series = Book::Serie.all_sorted_with_author
    @languages = Book::Language.all_sorted
  end

  def create
    @book = Book::Book.new(params[:book_book])

    if @book.save
      redirect_to(book_books_path, :flash => { :success => "Book was successfully created..." })
    else
      @authors = Book::Author.all_sorted
      @publishers = Book::Publisher.all_sorted
      @genres = Book::Genre.all_sorted
      @series = Book::Serie.all_sorted_with_author
      @languages = Book::Language.all_sorted
      render :action => "new"
    end
  end

  def update
    @book = Book::Book.find(params[:id])

    if @book.update_attributes(params[:book_book])
      redirect_to(book_books_path, :flash => { :success => "Book was successfully updated..." })
    else
      @authors = Book::Author.all_sorted
      @publishers = Book::Publisher.all_sorted
      @genres = Book::Genre.all_sorted
      @series = Book::Serie.all_sorted_with_author
      @languages = Book::Language.all_sorted
      render :action => "edit"
    end
  end

  def destroy
    @book = Book::Book.find(params[:id])
    @book.destroy

    redirect_to(book_books_url, :flash => { :success => "Book was successfully destroyed..." })
  end
end