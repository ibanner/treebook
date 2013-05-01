require 'test_helper'
# For addind the error messages:
# puts user.errors.inspect

class UserTest < ActiveSupport::TestCase
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
    user = User.new
    user.profile_name = "Itay Banner"

    assert !user.save
    assert !user.errors[:profile_name].empty?
    assert user.errors[:profile_name].include?("can't contain spaces")
  end
end
