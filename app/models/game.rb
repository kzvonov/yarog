class Game < ApplicationRecord
  has_many :game_heroes, class_name: "GameHero", dependent: :destroy
  has_many :heroes, class_name: "Hero", through: :game_heroes

  validates :name, presence: true

  def add_hero(hero)
    return false if heroes.include?(hero)

    game_heroes.create(hero: hero, game_index: heroes.count)
  end

  def remove_hero(hero)
    if heroes.include?(hero)
      game_heroes.find_by(hero:)&.destroy
      true
    else
      false
    end
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

  def remove_hero_by_code(code)
    hero = Hero.find_by(code: code)
    return { success: false, error: "Hero not found" } unless hero

    if remove_hero(hero)
      { success: true }
    else
      { success: false, error: "Hero is not in the game" }
    end
  end

  def activate!
    transaction do
      # Get all hero IDs in this game
      hero_ids = heroes.pluck(:id)

      # Find all other games that contain any of these heroes
      Game.where.not(id: id)
          .joins(:game_heroes)
          .where(game_heroes: { hero_id: hero_ids })
          .distinct
          .update_all(active: false)

      # Activate this game
      update!(active: true)
    end
  end
end
