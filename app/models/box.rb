class Box < ApplicationRecord
  has_many :squares

  def has_trellis
    squares.each do |s|
      return true if s[:has_trellis] == true
    end
  end
end
