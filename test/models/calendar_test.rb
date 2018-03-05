require 'test_helper'

class CalendarTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "last frost datetime" do
    c = calendars(:one)
    dt1 = DateTime.parse(c.last_frost)
    dt2 = DateTime.new(2018, 05, 13)
    assert_equal dt1, dt2 
  end
end
