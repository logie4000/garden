class CreateJoinTableSeasonSquare < ActiveRecord::Migration[5.1]
  def change
    create_join_table :seasons, :squares do |t|
      # t.index [:season_id, :square_id]
      # t.index [:square_id, :season_id]
    end
  end
end
