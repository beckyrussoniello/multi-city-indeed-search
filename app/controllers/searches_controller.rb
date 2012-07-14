class SearchesController < ApplicationController

  def new
    @search = Search.new
    @location = Location.new # this is only so fields_for will work
  end

  def create
    @search = Search.new(params[:search]) 
    @location = params[:location][:name]
    if @location and !@location.empty? and @search.save
	flash[:notice] = "FYI, we only process 10 locations at a time." if Search.too_many?(@location)
        session[:locations] = @location.split(",").uniq[0..LOCS_LIMIT] # limit number of locations
        redirect_to @search
    else
	flash[:notice] = case params[:search][:query]
          when (nil or "") then "Please type a search keyword.  What type of job are you looking for?"
	  else "Please type one or more locations, separated by commas."
	end
        redirect_to action: "new"
    end
  end

  def show
    @search = Search.find(params[:id])
    @location = Location.new # this is only so fields_for will work
    @results = @search.perform(session[:locations])
  end

end


