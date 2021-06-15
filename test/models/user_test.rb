require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "valid: user with all valid things" do
    user = User.new(email: "3@a.com", password_digest: "123456", role: 1)
    assert user.valid?
  end

  test "invalid: user with invalid email" do
    user = User.new(email: "444", password_digest: "123456", role: 1)
    assert_not user.valid?
  end

  test "invalid: user with taken email" do
    user = User.new(email: users(:one).email, password_digest: "123456", role: 1)
    assert_not user.valid?
  end

  test "invalid: user with invalid password_digest" do
    user = User.new(email: "4@a.com", password_digest: "", role: 1)
    assert_not user.valid?
  end

  test "invalid: user with invalid role" do
    user = User.new(email: "5@a.com", password_digest: "123456", role: 9)
    assert_not user.valid?
  end
end
