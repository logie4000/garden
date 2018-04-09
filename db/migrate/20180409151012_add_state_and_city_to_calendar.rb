class AddStateAndCityToCalendar < ActiveRecord::Migration[5.1]
  def change
    add_column :calendars, :city, :string
    add_column :calendars, :state, :string
  end
end
