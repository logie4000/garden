module CropsHelper
  def calculate_start_date(crop)
    weeks = crop.start_offset / 7
    days = crop.start_offset % 7
    return "#{weeks} weeks and #{days} days #{crop.start_date} (#{ crop.get_start_datetime().to_date() })"
  end

  def calculate_transplant_date(crop)
    weeks = crop.transplant_offset / 7
    days = crop.transplant_offset % 7
    return "#{weeks} weeks and #{days} days #{crop.transplant_date} (#{ crop.get_transplant_datetime().to_date() })"
  end

  def calculate_harvest_date(crop)
    return "#{crop.days_to_maturity} days after #{crop.transplant ?  "transplant" : "direct seeding"} (#{ crop.get_harvest_datetime().to_date() })"
  end

end
