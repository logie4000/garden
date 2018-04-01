class AddSquareToSeason < ActiveRecord::Migration[5.1]
  def change
    add_reference :seasons, :square, foreign_key: true, index: true
  end
end
