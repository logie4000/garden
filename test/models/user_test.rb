require 'test_helper'

class UserTest < ActiveSupport::TestCase

  test "generate an api key" do
    api_key = User.generate_api_key

    assert api_key
  end

  test "ensure api key is unique" do
    api_key = User.generate_api_key
    user = User.find_by_api_key(api_key)

    assert user.nil?
  end

end
