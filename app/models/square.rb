class Square < ApplicationRecord
  belongs_to :box
  has_and_belongs_to_many :seasons

  def name
    return "Box #{box.label}: #{self.row},#{self.column}"
  end

  def current_season
    cur_season = nil
    if (self.seasons)
      latest_date = Date.parse("2018-03-01") - 1
      self.seasons.each do |season|
        if (season.transplant?)
          unless (season.transplant_date.empty?)
            dt = Date.parse(season.transplant_date)
            cur_season = season if (dt <= Date.today && dt > latest_date)
          end
        else
          unless (season.start_date.empty?)
            dt = Date.parse(season.start_date)
            cur_season = season if (dt <= Date.today && dt > latest_date)
          end
        end
      end
    end

    return cur_season
  end
      
end
