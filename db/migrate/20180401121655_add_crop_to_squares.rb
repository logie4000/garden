class AddCropToSquares < ActiveRecord::Migration[5.1]
  def change
    add_reference :squares, :crop, foreign_key: true, index: true
  end
end
