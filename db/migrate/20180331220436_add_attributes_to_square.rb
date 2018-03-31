class AddAttributesToSquare < ActiveRecord::Migration[5.1]
  def change
    add_reference :squares, :box, foreign_key: true
    add_column :squares, :has_trellis, :boolean
  end
end
