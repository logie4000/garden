require 'test_helper'

class LocationTest < ActiveSupport::TestCase
  test "get last frost datetime" do
    loc = locations(:garden_boxes)
    result = loc.get_last_frost
    expected = DateTime.parse(DEFAULT_LAST_FROST)

    assert_equal expected, result
  end

end
