class Book::AuthorsController < ApplicationController
  before_filter :check_rights
  
  def index
    @authors = Book::Author.paginate :page => params[:page], :order => "name ASC", :per_page => 25
    @count = @authors.length
  end
  
  def check_rights
    @has_rights = (@user.has_rights_for?([RIGHTS[:admin], RIGHTS[:book_admin]]) rescue false)
  end
  
  def show
    @author = Book::Author.find(params[:id])
  end

  def new
    @author = Book::Author.new
  end

  def edit
    @author = Book::Author.find(params[:id])
  end

  def create
    @author = Book::Author.new(params[:book_author])

    if @author.save
      redirect_to(book_authors_path, :flash => { :success => "Author was successfully created..." })
    else
      render :action => "new"
    end
  end

  def update
    @author = Book::Author.find(params[:id])

    if @author.update_attributes(params[:book_author])
      redirect_to(book_authors_path, :flash => { :success => "Author was successfully updated..." })
    else
      render :action => "edit"
    end
  end

  def destroy
    @author = Book::Author.find(params[:id])
    @author.destroy

    redirect_to(book_authors_url, :flash => { :success => "Author was successfully destroyed..." })
  end
end