require 'test_helper'

class CropTest < ActiveSupport::TestCase
  test "get start datetime with transplant offset" do
    crop = crops(:tomato)
    result = crop.get_start_datetime()
    expected = DateTime.parse(DEFAULT_LAST_FROST)
    expected += -21 # Start offset
    expected += 7   # Transplant offset

    assert_equal expected, result
  end

  test "get start datetime without transplant offset" do
    crop = crops(:radish)
    result = crop.get_start_datetime()
    expected = DateTime.parse(DEFAULT_LAST_FROST)
    expected += -21 # Start offset

    assert_equal expected, result
  end

  test "get harvest time without transplant offset" do
    crop = crops(:radish)
    result = crop.get_harvest_datetime()
    expected = DateTime.parse(DEFAULT_LAST_FROST)
    expected += -21  # Start offset
    expected += 55   # Days to maturity offset

    assert_equal expected, result
  end

  test "get transplant datetime with transplant offset" do
    crop = crops(:tomato)
    result = crop.get_transplant_datetime()
    expected = DateTime.parse(DEFAULT_LAST_FROST)
    expected += 7   # Transplant offset

    assert_equal expected, result
  end

  test "get start offset in weeks" do
    crop = crops(:tomato)
    result = crop.start_offset_weeks()
    expected = 3

    assert_equal expected, result
  end

  test "get transplant offset in weeks" do
    crop = crops(:tomato)
    result = crop.transplant_offset_weeks()
    expected = 1

    assert_equal expected, result
  end

  test "set start offset in weeks" do
    crop = crops(:tomato)
    crop.start_offset_weeks = 4
    result = crop.start_offset
    expected = 28

    assert_equal expected, result
  end

  test "set transplant offset in weeks" do
    crop = crops(:tomato)
    crop.transplant_offset_weeks = 4
    result = crop.transplant_offset
    expected = 28

    assert_equal expected, result
  end
end
