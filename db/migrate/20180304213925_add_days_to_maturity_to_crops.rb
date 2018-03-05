class AddDaysToMaturityToCrops < ActiveRecord::Migration[5.1]
  def change
    add_column :crops, :days_to_maturity, :integer, :default => 0
  end
end
