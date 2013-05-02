require 'test_helper'

class StatusTest < ActiveSupport::TestCase
  test "that a status requires content" do
    status = Status.new
    assert !status.save
    assert !status.errors[:content].empty?
  end

  test "that a status is at least 2 chars long" do
    status = Status.new
    status.content = "Z"
    assert !status.save
    assert !status.errors[:content].empty?
  end

  test "that a status has a user_id associated with it" do
    status = Status.new
    status.content = "Valid Content"
    assert !status.save
    assert !status.errors[:user_id].empty?
  end
end
