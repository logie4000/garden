class CreateSquares < ActiveRecord::Migration[5.1]
  def change
    create_table :squares do |t|
      t.integer :row
      t.integer :column

      t.timestamps
    end
  end
end
