class Image < ApplicationRecord
  belongs_to :imageable, polymorphic: true

  mount_uploader :file, ImageUploader
  validate :image_size_validation

private
  def image_size_validation
    errors[:file] << "should be less than 5MiB" if file.size > 5.megabytes
  end
end
