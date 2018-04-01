class AddLocationIdToBoxes < ActiveRecord::Migration[5.1]
  def change
    add_reference :boxes, :location, foreign_key: true

    remove_reference :locations, :box, index: true, foreign_key: true
  end
end
