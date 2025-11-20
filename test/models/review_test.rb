require "test_helper"

class ReviewTest < ActiveSupport::TestCase
  setup do
    @user = users(:user_one)
    @movie = movies(:movie_one)
  end

  test "valid review" do
    review = @movie.reviews.new(user: @user, stars: 5, comment: "Great movie")
    assert review.valid?
  end

  test "rejects invalid stars" do
    review = @movie.reviews.new(user: @user, stars: 6, comment: "Too high")
    refute review.valid?
  end

  test "stars_as_percent returns correct value" do
    review = @movie.reviews.create!(user: @user, stars: 4, comment: "Good")
    assert_equal 80.0, review.stars_as_percent
  end
end