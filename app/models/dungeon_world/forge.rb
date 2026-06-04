module DungeonWorld
  module Forge

    BLOCKS = {

  }.freeze

    module_function

    def call(character)
      raise "character is already persisted in the DB" if character.persisted?
      raise "invalid #{character.type} for DungeonWorld" if character.type != DungeonWorld::Character.to_s

      templates = [
        DungeonWorld::Origin.get_template(character.origin),
        DungeonWorld::Klass.get_template(character.klass)
      ]
      result = templates.reduce({}) do |acc, temp|
        acc[:vitals] = (acc[:vitals] || {}).merge(temp[:vitals] || {})

        acc[:abilities] ||= { moves: [] }
        acc[:abilities][:moves] = (acc[:abilities][:moves] + (temp[:abilities] || [])).uniq

        acc[:inventory] = {
          weapons: ((acc.dig(:inventory, :weapons) || []) + (temp.dig(:inventory, :weapons) || [])).uniq,
          equipment: ((acc.dig(:inventory, :equipment) || []) + (temp.dig(:inventory, :equipment) || [])).uniq
        }

        acc[:story] ||= { bonds: "", alignment: "", looks: "", notes: "" }

        acc
      end

      # Calculate HP max and current
      con_value = result[:vitals][:con] || 10
      con_modifier = Helper.stat_modifier(con_value)
      hp_base = result[:vitals][:hp_base] || 8
      result[:vitals][:hp_max] = hp_base + con_modifier
      result[:vitals][:hp_current] = result[:vitals][:hp_max]

      character.vitals = result[:vitals]
      character.abilities = result[:abilities]
      character.inventory = result[:inventory]
      character.story = result[:story]

      character
    end
  end
end