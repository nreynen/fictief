class Book::LanguagesController < ApplicationController
  before_filter :check_rights
  
  def index
    @languages = Book::Language.all_sorted.paginate :page => params[:page], :order => "name ASC", :per_page => 25
    @count = @languages.length
  end
  
  def check_rights
    @has_rights = (@user.has_rights_for?([RIGHTS[:admin], RIGHTS[:book_admin]]) rescue false)
  end
  
  def show
    @language = Book::Language.find(params[:id])
  end

  def new
    @language = Book::Language.new
  end

  def edit
    @language = Book::Language.find(params[:id])
  end

  def create
    @language = Book::Language.new(params[:book_language])

    if @language.save
      redirect_to(book_languages_path, :flash => { :success => "Language was successfully created..." })
    else
      render :action => "new"
    end
  end

  def update
    @language = Book::Language.find(params[:id])

    if @language.update_attributes(params[:book_language])
      redirect_to(book_languages_path, :flash => { :success => "Language was successfully updated..." })
    else
      render :action => "edit"
    end
  end

  def destroy
    @language = Book::Language.find(params[:id])
    @language.destroy

    redirect_to(book_languages_url, :flash => { :success => "Language was successfully destroyed..." })
  end
end