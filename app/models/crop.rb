class Crop < ApplicationRecord
  belongs_to :location

  def get_start_datetime
    d_day = self.location.get_last_frost()
    offset = self.start_offset

    if (self.transplant?)
      d_day = get_transplant_datetime()
    end

    if (self.start_date.downcase.start_with?("before"))
      offset = -offset
    end

    return d_day + offset
  end

  def get_transplant_datetime
    d_day = self.location.get_last_frost()
    offset = 0

    if (self.transplant?)
      offset = self.transplant_offset
    end

    if (self.transplant_date.downcase.start_with?("before"))
      offset = -offset
    end

    return d_day + offset
  end

  def get_harvest_datetime
    d_day = get_start_datetime
    if (self.transplant?)
     d_day = get_transplant_datetime
    end

    offset = self.days_to_maturity || 0

    h_day = d_day + self.days_to_maturity

    return h_day
  end

  def start_offset_weeks
    return self.start_offset / 7
  end

  def transplant_offset_weeks
    return self.transplant_offset / 7
  end

  def start_offset_weeks= (weeks)
   self.start_offset = weeks * 7
  end

  def transplant_offset_weeks= (weeks)
    self.transplant_offset = weeks * 7
  end

end