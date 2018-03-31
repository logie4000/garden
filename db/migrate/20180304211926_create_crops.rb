class CreateCrops < ActiveRecord::Migration[5.1]
  def change
    create_table :crops do |t|
      t.string :name
      t.string :start_date
      t.boolean :transplant
      t.string :transplant_date
      t.references :location, foreign_key: true

      t.timestamps
    end
  end
end
