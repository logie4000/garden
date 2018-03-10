class AddImageToCrops < ActiveRecord::Migration[5.1]
  def change
    add_column :crops, :image, :string, :default => ""
  end
end
