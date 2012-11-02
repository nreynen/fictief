class NewsFeedsController < ApplicationController
  before_filter :ensure_logged_in
  before_filter lambda { |x| x.ensure_is_admin([RIGHTS[:admin], RIGHTS[:bread_admin]])}
  
  def index
    @feeds = NewsFeed.paginate :page => params[:page], :order => "id", :per_page => 25
  end
  
  def new
    @feed = NewsFeed.new
  end
  
  def create
    @feed = NewsFeed.new(params[:news_feed])
    
    if @feed.save
      redirect_to(news_feeds_path, :flash => { :success => "NewsFeed was successfully created..." })
    else
      render :action => "new"
    end
  end
end