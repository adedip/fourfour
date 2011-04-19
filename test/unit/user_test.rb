require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "nick" do
    session = {}
    user = User.new session
    assert user.nick = "Alessio"
    assert_equal "Alessio", user.nick
  end
end
