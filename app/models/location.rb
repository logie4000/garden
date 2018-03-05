class Location < ApplicationRecord
  belongs_to :calendar

  def get_last_frost
    begin
      d_day = DateTime.parse(self.calendar.last_frost)
    end

    return d_day
  end
end
