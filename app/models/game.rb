class Game < ApplicationRecord
  has_many :game_heroes, class_name: "GameHero", dependent: :destroy
  has_many :heroes, class_name: "Hero", through: :game_heroes

  validates :name, presence: true

  def add_hero(hero)
    return false if heroes.include?(hero)

    game_heroes.create(hero: hero, game_index: heroes.count)
  end

  def add_hero_by_code(code)
    hero = Hero.find_by(code: code)
    return { success: false, error: "Hero not found" } unless hero

    if add_hero(hero)
      { success: true, hero: hero }
    else
      { success: false, error: "Hero already in game" }
    end
  end
end
