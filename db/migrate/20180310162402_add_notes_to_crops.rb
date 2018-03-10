class AddNotesToCrops < ActiveRecord::Migration[5.1]
  def change
    add_column :crops, :notes, :text
  end
end
