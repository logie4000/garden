class AddRowsAndColumnsToBoxes < ActiveRecord::Migration[5.1]
  def change
    add_column :boxes, :rows, :integer
    add_column :boxes, :cols, :integer
  end
end
