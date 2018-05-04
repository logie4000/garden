class Location < ApplicationRecord
  belongs_to :calendar
  has_many :images, as: :imageable
  belongs_to :portrait, :class_name => "Image"
  has_many :boxes

  mount_uploader :image, ImageUploader

  def get_last_frost
    begin
      d_day = DateTime.parse(self.calendar.last_frost)
    end

    return d_day
  end
end
