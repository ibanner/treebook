require 'test_helper'

class UserFriendshipTest < ActiveSupport::TestCase
  should belong_to(:user)
  should belong_to(:friend)

  test "that creating a friendship works without raising an exception" do
    assert_nothing_raised do
      UserFriendship.create user: users(:itay), friend: users(:user3)
    end
  end

  test "that creating a friendship based on user_id and friend_id works" do
    UserFriendship.create user_id: users(:itay).id, friend_id: users(:user3).id
    assert users(:itay).friends.include?(users(:user3))
  end
end
