module ApplicationHelper
  def location_name(location)
    unless (location.nil?)
      return location.name
    end

    return ""
  end

  def calendar_name(calendar)
    unless (calendar.nil?)
      return calendar.name
    end

    return ""
  end

  def location_link(location)
    link_text = location_name(location)
    return link_to(link_text, location)
  end

  def calendar_link(calendar)
    link_text = calendar_name(calendar)
    return link_to(link_text, calendar)
  end

  def today?(datetime)
    today_date = Date.today
    return (datetime.strftime("%Y-%m-%d") == today_date.strftime("%Y-%m-%d"))
  end
end
