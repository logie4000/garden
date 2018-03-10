class Location < ApplicationRecord
  belongs_to :calendar
  validate :image_size_validation

  mount_uploader :image, ImageUploader
  
  def get_last_frost
    begin
      d_day = DateTime.parse(self.calendar.last_frost)
    end

    return d_day
  end

private
  def image_size_validation
    errors[:image] << "should be less than 500KB" if image.size > 0.5.megabytes
  end
end
