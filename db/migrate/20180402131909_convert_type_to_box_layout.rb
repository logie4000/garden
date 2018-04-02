class ConvertTypeToBoxLayout < ActiveRecord::Migration[5.1]
  def change
    remove_column :boxes, :type
    add_column :boxes, :box_layout, :string
  end
end
