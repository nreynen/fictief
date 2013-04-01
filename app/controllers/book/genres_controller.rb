class Book::GenresController < ApplicationController
  before_filter :check_rights
  
  def index
    @genres = Book::Genre.all_sorted.paginate :page => params[:page], :order => "name ASC", :per_page => 25
    @count = @genres.length
  end
  
  def check_rights
    @has_rights = (@user.has_rights_for?([RIGHTS[:admin], RIGHTS[:book_admin]]) rescue false)
  end
  
  def show
    @genre = Book::Genre.find(params[:id])
  end

  def new
    @genre = Book::Genre.new
  end

  def edit
    @genre = Book::Genre.find(params[:id])
  end

  def create
    @genre = Book::Genre.new(params[:book_genre])

    if @genre.save
      redirect_to(book_genres_path, :flash => { :success => "Genre was successfully created..." })
    else
      render :action => "new"
    end
  end

  def update
    @genre = Book::Genre.find(params[:id])

    if @genre.update_attributes(params[:book_genre])
      redirect_to(book_genres_path, :flash => { :success => "Genre was successfully updated..." })
    else
      render :action => "edit"
    end
  end

  def destroy
    @genre = Book::Genre.find(params[:id])
    @genre.destroy

    redirect_to(book_genres_url, :flash => { :success => "Genre was successfully destroyed..." })
  end
end