class AddActiveToGames < ActiveRecord::Migration[8.0]
  def change
    add_column :games, :active, :boolean, default: false, null: false
  end
end
