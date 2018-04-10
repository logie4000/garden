require 'test_helper'

class WeatherDatumTest < ActiveSupport::TestCase
  test "return max_temp from model" do
    data = weather_data(:two)
    expected = 39
    result = data.max_temp(UNIT_IMPERIAL)

    assert_equal expected, result
  end

  test "return min_temp from model" do
    data = weather_data(:two)
    expected = 23
    result = data.min_temp(UNIT_IMPERIAL)

    assert_equal expected, result
  end

  test "return precip from model" do
    data = weather_data(:two)
    expected = 0.00
    result = data.precip(UNIT_IMPERIAL)

    assert_equal expected, result
  end

  test "return snowfall from model" do
    data = weather_data(:two)
    expected = 0.00
    result = data.snowfall(UNIT_IMPERIAL)

    assert_equal expected, result
  end
  
end
