class WeatherDatum < ApplicationRecord

  MAX_TEMP = "maxtemp"
  MIN_TEMP = "mintemp"
  PRECIP = "precip"
  MAX_PRESS = "maxpressure"
  MIN_PRESS = "minpressure"
  SNOWFALL = "snowfall"

  def max_temp(unit = UNIT_METRIC)
    return self.get(MAX_TEMP, unit).to_i
  end

  def min_temp(unit = UNIT_METRIC)
    return self.get(MIN_TEMP, unit).to_i
  end

  def precip(unit = UNIT_METRIC)
    return self.get(PRECIP, unit).to_f
  end

  def snowfall(unit = UNIT_METRIC)
    return self.get(SNOWFALL, unit).to_f
  end

  def get(attr, unit = UNIT_METRIC)
#    Rails.logger.debug "Parsing JSON data: #{self[:raw]}"
    json = JSON.parse("#{self[:raw]}")

    u = "m"
    u = "i" if (unit == UNIT_IMPERIAL)
#    Rails.logger.debug "JSON DUMP: #{json.inspect}"

    return json["#{attr}#{u}"]
  end
end
