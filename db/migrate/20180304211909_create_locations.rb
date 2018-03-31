class CreateLocations < ActiveRecord::Migration[5.1]
  def change
    create_table :locations do |t|
      t.string :name
      t.references :calendar, foreign_key: true
      t.boolean :auto_water

      t.timestamps
    end
  end
end
