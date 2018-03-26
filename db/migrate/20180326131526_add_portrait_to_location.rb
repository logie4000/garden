class AddPortraitToLocation < ActiveRecord::Migration[5.1]
  def change
    add_reference :locations, :portrait, index: true
    add_foreign_key :locations, :images, column: :portrait_id
  end
end
