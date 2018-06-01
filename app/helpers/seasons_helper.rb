module SeasonsHelper

  def square_list(season)
    season.squares.map(&:name).join("; ")
  end

  def planted_days(season)
    dt_end = Date.today
    unless (season.harvest_date.blank?)
      dt_harvest = Date.parse(season.harvest_date)
      dt_end = ( dt_harvest > Date.today ? Date.today : dt_harvest )
    end 
     
    if (season.crop.transplant)
      unless (season.transplant_date.blank?)
        dt_transplant = Date.parse(season.transplant_date)
        if (dt_end > dt_transplant)
          return (dt_end - dt_transplant).to_i
        else
          return 0 # Transplant, transplant date is greater than today
        end
      else
        return 0 # Transplant, no transplant date yet
      end
    else
      unless (season.start_date.blank?)
        dt_start = Date.parse(season.start_date)
        if (dt_end > dt_start)
          return (dt_end - dt_start).to_i
        else
          return 0 # Not a transplant, season start date is greater than today
        end
      else
        return 0 # Not a transplant, no season start date
      end
    end
  end

  def planting_offset(season)
    if (season.start_date.blank?)
      return 0
    else
      dt_start = Date.parse(season.start_date)
    end

    if (season.crop.transplant ||  !season.transplant_date.blank?)
      if (season.transplant_date.blank?)
        return (Date.today - dt_start).to_i if (Date.today > dt_start)
      else
        dt_transplant = Date.parse(season.transplant_date)
        return (dt_transplant - dt_start).to_i if (dt_transplant > dt_start)
      end
    end

    return 0
  end
      
end
