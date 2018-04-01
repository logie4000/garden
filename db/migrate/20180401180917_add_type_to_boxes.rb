class AddTypeToBoxes < ActiveRecord::Migration[5.1]
  def change
    add_column :boxes, :type, :string
  end
end
