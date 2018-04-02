class Crop < ApplicationRecord
  belongs_to :location
  has_many :seasons
  has_many :images, as: :imageable
  has_one :portrait, :class_name => "Image", as: :imageable
  
  mount_uploader :image, ImageUploader

  accepts_nested_attributes_for :seasons, :reject_if => proc {|attributes| attributes[:year].blank?}

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

  def get_actual_start_datetime
    season = self.seasons.last
    if (season)
      return Date.parse(season.start_date) if (season.start_date)
    end
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

  def get_actual_transplant_datetime
    season = self.seasons.last
    if (season)
      return Date.parse(season.transplant_date) if (season.transplant_date)
    end
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
