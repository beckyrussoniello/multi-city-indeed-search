class SearchesController < ApplicationController

  def new
    @search = Search.new
    @location = Location.new # this is only so fields_for will work
  end

  def create
    @search = Search.new(params[:search]) 
    @locs = params[:location][:name]
    if @locs and !@locs.empty? and @search.save
        session[:locations] = @locs.split(",").uniq[0..LOCS_LIMIT] # limit number of locations
        redirect_to @search
    else
        render action: "new"
    end
  end

  def show
    @search = Search.find(params[:id])
    @results = @search.perform(session[:locations])
  end
end
