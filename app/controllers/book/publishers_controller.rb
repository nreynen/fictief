class Book::PublishersController < ApplicationController
  before_filter :ensure_logged_in
  before_filter lambda { |x| x.ensure_is_admin([RIGHTS[:admin], RIGHTS[:book_admin]])}
  
  def create
    @publisher = Book::Publisher.new(params[:book_publisher].permit(:name, :place))
    
    if @publisher.save
      redirect_to(book_publishers_path, :flash => { :success => "Publisher was successfully created..." })
    else
      render :action => "new"
    end
  end
  
  def edit
    @publisher = Book::Publisher.find(params[:id])
  end
  
  def index
    @publishers = Book::Publisher.paginate :page => params[:page], :order => "name", :per_page => 25
  end
  
  def new
    @publisher = Book::Publisher.new
  end
  
  def show
    @publisher = Book::Publisher.find(params[:id])
  end
  
  def update
    @publisher = Book::Publisher.find(params[:id])
    
    if @publisher.update_attributes(params[:book_publisher].permit(:name, :place))
      redirect_to(book_publishers_path, :flash => { :success => "Publisher was successfully updated..." })
    else
      render :action => "edit"
    end
  end
end