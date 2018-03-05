require 'test_helper'

class CropTest < ActiveSupport::TestCase
  test "get start datetime with transplant offset" do
    crop = crops(:tomato)
    result = crop.get_start_datetime()
    expected = DateTime.new(2018, 05, 13)
    expected += -21 # Start offset
    expected += 7   # Transplant offset

    assert_equal expected, result
  end

  test "get start datetime without transplant offset" do
    crop = crops(:radish)
    result = crop.get_start_datetime()
    expected = DateTime.new(2018, 05, 13)
    expected += -21 # Start offset

    assert_equal expected, result
  end

  test "get harvest time without transplant offset" do
    crop = crops(:radish)
    result = crop.get_harvest_datetime()
    expected = DateTime.new(2018, 05, 13)
    expected += -21  # Start offset
    expected += 55   # Days to maturity offset

    assert_equal expected, result
  end
end
