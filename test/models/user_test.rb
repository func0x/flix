require "test_helper"

class UserTest < ActiveSupport::TestCase
  setup do
    @user = users(:user_one)
  end

  test "valid user" do
    assert @user.valid?
  end

  test "formats username and email before save" do
    @user.username = "Alice123"
    @user.email = "ALICE@EXAMPLE.COM"
    @user.save
    assert_equal "alice123", @user.username
    assert_equal "alice@example.com", @user.email
  end

  test "gravatar_id is correct" do
    expected = Digest::MD5.hexdigest(@user.email.downcase)
    assert_equal expected, @user.gravatar_id
  end

  test "to_param returns username" do
    assert_equal @user.username, @user.to_param
  end
end