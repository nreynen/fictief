class Workday::SequencesController < ApplicationController
  before_filter :check_rights
  
  def index
    @sequences = Workday::Sequence.paginate :page => params[:page], :order => "id ASC", :per_page => 25
    @count = @sequences.length
  end
  
  def check_rights
    @has_rights = (@user.has_rights_for?([RIGHTS[:admin], RIGHTS[:workday_user]]) rescue false)
  end

  def new
    @sequence = Workday::Sequence.new
    @options = @user.workday_designations.inject([]) do |a, x|
      a << "<option value='#{x.id}' style='background-color: ##{x.colour}' class='font_bordered'>#{x.name}</option>"
      a
    end.join
    @seq = @sequence.seq
  end

  def edit
    @sequence = Workday::Sequence.find(params[:id])
    @options = @user.workday_designations.inject([]) do |a, x|
      a << "<option value='#{x.id}' style='background-color: ##{x.colour}' class='font_bordered'>#{x.name}</option>"
      a
    end.join
    @seq = @sequence.seq
  end

  def create
    @sequence = Workday::Sequence.new(params[:workday_sequence])

    if @sequence.save
      redirect_to(workday_sequences_path, :flash => { :success => "Sequence was successfully created..." })
    else
      render :action => "new"
    end
  end

  def update
    @sequence = Workday::Sequence.find(params[:id])

    if @sequence.update_attributes(params[:workday_sequence])
      redirect_to(workday_sequences_path, :flash => { :success => "Sequence was successfully updated..." })
    else
      render :action => "edit"
    end
  end

  def destroy
    @sequence = Workday::Sequence.find(params[:id])
    @sequence.destroy

    redirect_to(workday_sequences_url, :flash => { :success => "Sequence was successfully destroyed..." })
  end
end