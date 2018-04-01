class Box < ApplicationRecord
  has_many :squares
  belongs_to :location

  def has_trellis
    squares.each do |s|
      return true if s[:has_trellis] == true
    end
  end
end
