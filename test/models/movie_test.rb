require "test_helper"

class MovieTest < ActiveSupport::TestCase
  setup do
    @movie = movies(:movie_one)
  end

  test "valid movie" do
    assert @movie.valid?
  end

  test "sets slug before save" do
    @movie.save
    assert_equal @movie.title.parameterize, @movie.slug
  end

  test "flop? detects correctly" do
    @movie.total_gross = 50_000_000
    assert @movie.flop?
    @movie.total_gross = 300_000_000
    refute @movie.flop?
  end
end