class GenresController < ApplicationController
  before_action :require_signin,

  def index
    @genres = Genre.order(:name)
  end

  def show
    @genre = Genre.find_by!(slug: params[:id])
    @movies = @genre.movies
  end

end
