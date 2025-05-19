class ReviewsController < ApplicationController
  before_action :require_signin
  before_action :set_movie

  def index
    @reviews = @movie.reviews
  end

  def new
    @review = @movie.reviews.new
  end

  def edit
    @review = @movie.reviews.find(params[:id])
  end

  def update
    @review = @movie.reviews.find(params[:id])

    if @review.update(review_params)
      flash[:notice] = "Review successfully updated!"
      redirect_to movie_reviews_url(@movie)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def create
    @review = @movie.reviews.new(review_params)
    @review.user = current_user

    if @review.save
      redirect_to movie_reviews_url(@movie), notice: "Thanks for your review!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    Rails.logger.debug { "Params: #{params.inspect}" }  # <= odpowiednik console.log
    @review = @movie.reviews.find(params[:id])
    @review.destroy

    redirect_to movie_review_path(@movie), status: :see_other, alert: "Review successfully deleted!"
  end

  private 

  def review_params
    params.require(:review).permit(:stars, :comment)
  end

  def set_movie
    @movie = Movie.find_by!(slug: params[:movie_id])
  end

end
