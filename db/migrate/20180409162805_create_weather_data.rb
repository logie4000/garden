class CreateWeatherData < ActiveRecord::Migration[5.1]
  def change
    create_table :weather_data do |t|
      t.text :raw
      t.string :date, index: true
      t.string :city
      t.string :state

      t.timestamps
    end

    add_index :weather_data, [:date, :state, :city], unique: true
  end
end
