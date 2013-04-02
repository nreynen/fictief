class Workday::DesignationsController < ApplicationController
  before_filter :check_rights
  
  def index
    @designations = Workday::Designation.paginate :page => params[:page], :order => "name ASC", :per_page => 25
    @count = @designations.length
  end
  
  def check_rights
    @has_rights = (@user.has_rights_for?([RIGHTS[:admin], RIGHTS[:workday_user]]) rescue false)
  end

  def new
    @designation = Workday::Designation.new
  end

  def edit
    @designation = Workday::Designation.find(params[:id])
  end

  def create
    @designation = Workday::Designation.new(params[:workday_designation])

    if @designation.save
      redirect_to(workday_designations_path, :flash => { :success => "Designation was successfully created..." })
    else
      render :action => "new"
    end
  end

  def update
    @designation = Workday::Designation.find(params[:id])

    if @designation.update_attributes(params[:workday_designation])
      redirect_to(workday_designations_path, :flash => { :success => "Designation was successfully updated..." })
    else
      render :action => "edit"
    end
  end

  def destroy
    @designation = Workday::Designation.find(params[:id])
    @designation.destroy

    redirect_to(workday_designations_url, :flash => { :success => "Designation was successfully destroyed..." })
  end
end