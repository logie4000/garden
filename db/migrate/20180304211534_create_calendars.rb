class CreateCalendars < ActiveRecord::Migration[5.1]
  def change
    create_table :calendars do |t|
      t.string :name
      t.string :last_frost

      t.timestamps
    end
  end
end
