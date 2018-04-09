module CalendarsHelper

  def state_list
    states = %w(AL AK AZ AR CA CO CT DE FL GA HI ID IL IN IA KS KY LA ME MD MA MI MN MS MO MT NE NV NH NJ NM NY NC ND OH OK OR PA RI SC SD TN TX UT VT VA WA WV WI WY)
    return states
  end

  def city_name(calendar)
    return "#{calendar.city}, #{calendar.state}" if (calendar.city && calendar.state)
  end
end
