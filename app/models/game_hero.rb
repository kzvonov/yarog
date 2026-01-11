class GameHero < ApplicationRecord
  self.table_name = "game_heroes"

  belongs_to :game
  belongs_to :hero, class_name: "Hero"

  validates :hero_id, uniqueness: { scope: :game_id }
end
