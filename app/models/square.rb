class Square < ApplicationRecord
  belongs_to :box
  has_and_belongs_to_many :seasons

  def name
    return "Box #{box.label}: #{self.row},#{self.column}"
  end
end
