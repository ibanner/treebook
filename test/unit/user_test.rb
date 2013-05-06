require 'test_helper'
# For addind the error messages:
# puts user.errors.inspect

class UserTest < ActiveSupport::TestCase
  should have_many(:user_friendships)
  should have_many(:friends)

  test "User must enter a first name" do
    user = User.new
    assert !user.save
    assert !user.errors[:first_name].empty?
  end

  test "User must enter a last name" do
    user = User.new
    assert !user.save
    assert !user.errors[:last_name].empty?
  end

  test "User must enter a profile name" do
    user = User.new
    assert !user.save
    assert !user.errors[:profile_name].empty?
  end

  test "User must enter a unique profile name" do
    user = User.new
    user.profile_name = users(:itay).profile_name

    assert !user.save
    assert !user.errors[:profile_name].empty?
  end

  test "User must enter a profile name without spaces" do
    user = User.new(first_name: "Itay", last_name: "Banner", email: "itay2@ibanner.co.il")
    user.password = user.password_confirmation = "1234qwer"
    
    user.profile_name = "Itay Banner"

    assert !user.save
    assert !user.errors[:profile_name].empty?
    assert user.errors[:profile_name].include?("can't contain spaces")
  end

  test "User can have a correctly formatted profile name" do
    user = User.new(first_name: "Itay", last_name: "Banner", email: "itay2@ibanner.co.il")
    user.password = user.password_confirmation = "1234qwer"
    user.profile_name = "ItayBanner_1"
    assert user.valid?
  end

  test "that nothing is raised when trying to access a friend list" do
    assert_nothing_raised do
      users(:itay).friends
    end
  end

  test "that creating friendships on a user works" do
    users(:itay).friends << users(:user3)
    users(:itay).friends.reload
    assert users(:itay).friends.include?(users(:user3))
  end
end
