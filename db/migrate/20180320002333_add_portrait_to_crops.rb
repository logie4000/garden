class AddPortraitToCrops < ActiveRecord::Migration[5.1]
  def change
    add_reference :crops, :portrait, index: true
    add_foreign_key :crops, :images, column: :portrait_id
  end
end
