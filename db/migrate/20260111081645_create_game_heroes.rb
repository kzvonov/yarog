class CreateGameHeroes < ActiveRecord::Migration[8.0]
  def change
    create_table :game_heroes do |t|
      t.references :game, null: false, foreign_key: true
      t.integer :hero_id, null: false
      t.foreign_key :heroes, column: :hero_id, primary_key: "id"
      t.integer :game_index

      t.timestamps
    end

    add_index :game_heroes, [ :game_id, :hero_id ], unique: true
  end
end
