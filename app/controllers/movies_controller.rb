class MoviesController < ApplicationController
  before_action :authenticate!

  def index
    @movies = Itunes::Movie.find_by_id(current_user.movies.map{|movie| movie.track_id})
  end

  def search
    if params[:term]
      @movies = Itunes::Movie.search(params[:term])
      respond_to do |format|
        format.js
      end
    end
  end

  def create
    @movie = Movie.new track_id: params[:track_id]
    current_user.movies << @movie
    respond_to do |format|
      format.js
    end
  end

  def destroy
    @movie = Movie.find_by track_id: params[:id]
    @movie.destroy

    respond_to do |format|
      format.js
    end
  end

end
