class Book::PublishersController < ApplicationController
  before_filter :check_rights
  
  def index
    @publishers = Book::Publisher.all_sorted.paginate :page => params[:page], :order => "name ASC", :per_page => 25
    @count = @publishers.length
  end
  
  def check_rights
    @has_rights = (@user.has_rights_for?([RIGHTS[:admin], RIGHTS[:book_admin]]) rescue false)
  end
  
  def show
    @publisher = Book::Publisher.find(params[:id])
  end

  def new
    @publisher = Book::Publisher.new
  end

  def edit
    @publisher = Book::Publisher.find(params[:id])
  end

  def create
    @publisher = Book::Publisher.new(params[:book_publisher])

    if @publisher.save
      redirect_to(book_publishers_path, :flash => { :success => "Publisher was successfully created..." })
    else
      render :action => "new"
    end
  end

  def update
    @publisher = Book::Publisher.find(params[:id])

    if @publisher.update_attributes(params[:book_publisher])
      redirect_to(book_publishers_path, :flash => { :success => "Publisher was successfully updated..." })
    else
      render :action => "edit"
    end
  end

  def destroy
    @publisher = Book::Publisher.find(params[:id])
    @publisher.destroy

    redirect_to(book_publishers_path, :flash => { :success => "Publisher was successfully destroyed..." })
  end
end