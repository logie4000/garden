require 'test_helper'

class CropTest < ActiveSupport::TestCase
  test "get start datetime" do
    crop = crops(:one)
    result = crop.get_start_datetime()
    expected = DateTime.new(2018, 05, 06)

    assert_equal expected, result
  end
end
