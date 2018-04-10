
module Weather
  def self.get_date_summary(date, city, state)
    key = WUNDERGROUND_API_KEY
    key.chomp!

    history_url = Weather.generate_history_url(date, city, state)
    url = "http://api.wunderground.com/api/#{WUNDERGROUND_API_KEY}/#{history_url}"
    Rails.logger.debug "Requesting historical weather data: url => #{url}"

    request = RestClient::Request.new(:method => :get,
                :url => url,
                :headers => {:content_type => :json, :accept => :json})

    result = request.execute
#    Rails.logger.debug "Result: #{result.inspect}"

    response_json = JSON.parse(result)
#    Rails.logger.debug "Result: #{response_json.inspect}"

    if (Weather.valid_summary?(response_json))
      return response_json['history']['dailysummary'][0] 
    else
      return nil
    end
  end

  def self.valid_summary?(json)
    if (json['history'])
      if (json['history']['dailysummary'])
        return true
      end
    end

    return false
  end

  def self.generate_history_url(date, city, state)
    dt = Date.parse(date)
    year = "#{dt.year}"
    month = "#{dt.month < 10 ? '0' : ''}#{dt.month}"
    day = "#{dt.day < 10 ? '0' : ''}#{dt.day}"

    return "history_#{year}#{month}#{day}/q/#{state}/#{city}.json"
  end
end
