class AddTransplantOffsetToCrops < ActiveRecord::Migration[5.1]
  def change
    add_column :crops, :start_offset, :integer, :default => 0
    add_column :crops, :transplant_offset, :integer, :default => 0
  end
end
