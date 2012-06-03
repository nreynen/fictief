class StaticsController < ApplicationController
  
  def index
    @statics = Static.paginate :page => params[:page], :order => "id", :per_page => 25
    @count = @statics.length
  end
  
  def edit
    @static = Static.find(params[:id])
    bla = 2
  end
  
  def update
    @static = Static.find(params[:id])

    if @static.update_attributes(params[:static])
      redirect_to(statics_path, :flash => { :success => "Static was successfully updated..." })
    else
      render :action => "edit"
    end
  end
  
  def destroy
    @static = Static.find(params[:id])
    @static.destroy

    redirect_to(statics_url, :flash => { :success => "Static was successfully destroyed..." })
  end
end