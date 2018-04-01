class AddBoxToLocations < ActiveRecord::Migration[5.1]
  def change
    add_reference :locations, :box, foreign_key: true, index: true
  end
end
