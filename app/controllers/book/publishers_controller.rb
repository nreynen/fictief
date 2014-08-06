class Book::PublishersController < ApplicationController
  before_filter :ensure_logged_in
  before_filter lambda { |x| x.ensure_is_admin([RIGHTS[:admin], RIGHTS[:book_admin]])}
  
  def create
    @author = Book::Author.new(params[:book_author].permit(:name))
    
    if @author.save
      redirect_to(book_authors_path, :flash => { :success => "Author was successfully created..." })
    else
      render :action => "new"
    end
  end
  
  def edit
    @author = Book::Author.find(params[:id])
  end
  
  def index
    @authors = Book::Author.paginate :page => params[:page], :order => "name", :per_page => 25
  end
  
  def new
    @author = Book::Author.new
  end
  
  def show
    @author = Book::Author.find(params[:id])
  end
  
  def update
    @author = Book::Author.find(params[:id])
    
    if @author.update_attributes(params[:book_author].permit(:name))
      redirect_to(book_authors_path, :flash => { :success => "Author was successfully updated..." })
    else
      render :action => "edit"
    end
  end
end