class Location < ApplicationRecord
  belongs_to :calendar
  has_many :images, as: :imageable
  has_one :portrait, :class_name => "Image", as: :imageable
<<<<<<< HEAD
  has_many :boxes
=======
>>>>>>> origin/master

  mount_uploader :image, ImageUploader

  def get_last_frost
    begin
      d_day = DateTime.parse(self.calendar.last_frost)
    end

    return d_day
  end
end
