class CreateSeasons < ActiveRecord::Migration[5.1]
  def change
    create_table :seasons do |t|
      t.references :crop, foreign_key: true
      t.string :year
      t.string :start_date
      t.string :transplant_date
      t.boolean :transplant
      t.string :harvest_date
      t.text :notes

      t.timestamps
    end

    add_index :seasons, [:crop_id, :year], :unique => true
  end
end
