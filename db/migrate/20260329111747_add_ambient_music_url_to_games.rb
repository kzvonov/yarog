class AddAmbientMusicUrlToGames < ActiveRecord::Migration[8.0]
  def change
    add_column :games, :ambient_music_url, :string, null: true
  end
end
