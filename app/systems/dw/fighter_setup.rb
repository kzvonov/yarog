require "json"
require_relative "base"

module Dw
  class FighterSetup
    attr_reader :character_data, :class_data

    def initialize
      @class_data = load_class_data
      reset_character_data
    end

    # Creates and saves a Fighter Hero to the database
    def create_fighter(name: nil, code: nil, options: {})
      reset_character_data

      # Generate race first (needed for name generation)
      race = options[:race] || random_race

      # Generate random name if not provided
      name ||= random_name_for_race(race)

      assign_stats(options[:stats] || suggested_stats)
      calculate_hp
      calculate_max_load
      add_starting_moves
      select_racial_move(race)
      select_alignment(options[:alignment])
      select_gear(options[:gear_choices] || {})
      select_bonds(options[:bonds] || [])
      customize_look(options[:look] || {})
      customize_signature_weapon(options[:signature_weapon] || {})
      calculate_current_load

      # Build Hero data structure
      hero_data = build_hero_data(name)

      # Create and save Hero (code will be auto-generated if nil)
      hero = Hero.new(
        code: code,
        specialization: "fighter",
        name: name,
        level: 1,
        xp: 0,
        data: hero_data.to_json,
        version: 0
      )

      hero.save!
      hero
    end

    # Returns character data hash without creating Hero (for preview/testing)
    def preview_fighter(options = {})
      reset_character_data

      assign_stats(options[:stats] || suggested_stats)
      calculate_hp
      calculate_max_load
      add_starting_moves
      select_racial_move(options[:race])
      select_alignment(options[:alignment])
      select_gear(options[:gear_choices] || {})
      select_bonds(options[:bonds] || [])
      customize_look(options[:look] || {})
      customize_signature_weapon(options[:signature_weapon] || {})
      calculate_current_load

      @character_data[:name] = options[:name] if options[:name]

      @character_data
    end

    def suggested_stats
      @class_data["base_stats"]["suggested_distribution"]
    end

    def available_races
      @class_data["moves"]["racial"].map { |m| m["race"] }
    end

    def available_alignments
      @class_data["alignment"]["choose_one"].map { |a| a["key"] }
    end

    def get_racial_move(race)
      @class_data["moves"]["racial"].find { |m| m["race"] == race }
    end

    def get_alignment(key)
      @class_data["alignment"]["choose_one"].find { |a| a["key"] == key }
    end

    def random_race
      available_races.sample
    end

    def random_name_for_race(race)
      names = @class_data.dig("hints", "names", race) || []
      names.sample || "Fighter"
    end

    private

    def reset_character_data
      @character_data = {
        class_id: @class_data["class_id"],
        class_name: @class_data["class_name"],
        level: 1,
        stats: {},
        max_hp: 0,
        current_hp: 0,
        damage_die: @class_data["stats"]["base_damage_die"],
        armor: 0,
        load: 0,
        max_load: 0,
        moves: [],
        gear: [],
        bonds: [],
        alignment: nil,
        name: nil,
        race: nil,
        look: {}
      }
    end

    def build_hero_data(name)
      {
        specialization: "fighter",
        name: name,
        look: format_look,
        origin: "",
        level: 1,
        xp: 0,
        hpCurrent: @character_data[:current_hp],
        hpMax: @character_data[:max_hp],
        armor: @character_data[:armor],
        damage: @character_data[:damage_die],
        stats: convert_stats_to_symbols,
        debilities: { str: false, dex: false, con: false, int: false, wis: false, cha: false },
        condition: "",
        moves: format_moves_for_hero,
        equipment: format_equipment,
        notes: format_notes
      }
    end

    def convert_stats_to_symbols
      stats = @character_data[:stats]
      {
        str: stats["STR"] || 10,
        dex: stats["DEX"] || 10,
        con: stats["CON"] || 10,
        int: stats["INT"] || 10,
        wis: stats["WIS"] || 10,
        cha: stats["CHA"] || 10
      }
    end

    def format_moves_for_hero
      @character_data[:moves].map do |move|
        {
          name: move["name"] || move["name_original"],
          desc: format_move_description(move)
        }
      end
    end

    def format_move_description(move)
      parts = []
      parts << move["description"] if move["description"]
      parts << "Триггер: #{move['trigger']}" if move["trigger"]
      parts << "Бросок: #{move['roll']}" if move["roll"]
      parts << "На 10+: #{move['on_10_plus']}" if move["on_10_plus"]
      parts << "На 7-9: #{move['on_7_9']}" if move["on_7_9"]
      parts << "На 6-: #{move['on_6_minus']}" if move["on_6_minus"]

      if move["choices"]
        parts << "Варианты: #{move['choices'].join('; ')}"
      end

      parts << "Эффект: #{move['effect']}" if move["effect"]
      parts << move["note"] if move["note"]

      parts.join(" | ")
    end

    def format_look
      return "" if @character_data[:look].empty?

      @character_data[:look].values.join(", ")
    end

    def format_equipment
      equipment_lines = []

      # Add signature weapon first
      if @character_data[:signature_weapon]
        weapon = @character_data[:signature_weapon]
        weapon_desc = "#{weapon[:base]}"
        weapon_desc += " (#{weapon[:weight]} вес)" if weapon[:weight]

        if weapon[:enhancements] && weapon[:enhancements].any?
          weapon_desc += " [#{weapon[:enhancements].join(', ')}]"
        end

        equipment_lines << "Оружие: #{weapon_desc}"
      end

      # Separate gear into categories
      armor_items = []
      consumables = []
      other_items = []

      @character_data[:gear].each do |item|
        next unless item.is_a?(Hash)

        name = item["item"] || ""
        next if name.empty?

        # Skip signature weapon in gear list (already added above)
        next if name == "Фирменное оружие" || name == "Именное оружие"

        weight = item["weight"] ? " (#{item['weight']})" : ""
        armor_val = item["armor"] ? " [Броня: #{item['armor']}]" : ""
        armor_bonus = item["armor_bonus"] ? " [+#{item['armor_bonus']} броня]" : ""
        uses = item["uses"] ? " x#{item['uses']}" : ""

        formatted_item = "#{name}#{uses}#{armor_val}#{armor_bonus}#{weight}"

        # Categorize items
        if item["armor"] || item["armor_bonus"] || name.include?("броня") || name.include?("Щит")
          armor_items << formatted_item
        elsif name.include?("Провизия") || name.include?("зелье") || name.include?("Пайки") ||
              name.include?("Противоядие") || name.include?("Мази")
          consumables << formatted_item
        else
          other_items << formatted_item
        end
      end

      # Build equipment string
      equipment_lines << "\nБроня и защита:" if armor_items.any?
      equipment_lines.concat(armor_items.map { |item| "- #{item}" })

      equipment_lines << "\nЗапасы и расходники:" if consumables.any?
      equipment_lines.concat(consumables.map { |item| "- #{item}" })

      equipment_lines << "\nПрочее снаряжение:" if other_items.any?
      equipment_lines.concat(other_items.map { |item| "- #{item}" })

      # Add weight summary
      total_weight = calculate_total_weight
      equipment_lines << "\nОбщий вес: #{total_weight} / #{@character_data[:max_load]}"

      equipment_lines.join("\n")
    end

    def calculate_total_weight
      total = 0

      # Add signature weapon weight
      total += @character_data[:signature_weapon][:weight] if @character_data[:signature_weapon]

      # Add gear weight
      @character_data[:gear].each do |item|
        total += item["weight"].to_i if item.is_a?(Hash) && item["weight"]
      end

      total
    end

    def format_notes
      notes = []

      # Add race info
      notes << "Раса: #{@character_data[:race]}" if @character_data[:race]

      # Add alignment
      if @character_data[:alignment]
        alignment = @character_data[:alignment]
        notes << "Мировоззрение: #{alignment['name']} - #{alignment['condition']}"
      end

      # Add bonds
      if @character_data[:bonds].any?
        notes << "\nУзы:"
        @character_data[:bonds].each { |bond| notes << "- #{bond}" }
      end

      # Add signature weapon
      if @character_data[:signature_weapon]
        weapon = @character_data[:signature_weapon]
        notes << "\nИменное оружие:"
        notes << "Тип: #{weapon[:base]}"
        notes << "Улучшения: #{weapon[:enhancements].join(', ')}" if weapon[:enhancements]
        notes << "Вид: #{weapon[:look]}"
      end

      notes.join("\n")
    end

    def load_class_data
      file_path = File.join(__dir__, "classes", "ru_fighter.json")
      JSON.parse(File.read(file_path))
    end

    def assign_stats(stats)
      @character_data[:stats] = stats

      # Calculate modifiers for each stat
      @character_data[:stat_modifiers] = {}
      stats.each do |stat, value|
        @character_data[:stat_modifiers][stat] = Base.modifier(value)
      end
    end

    def calculate_hp
      con = @character_data[:stats]["CON"] || 10
      con_mod = Base.modifier(con)
      @character_data[:max_hp] = 10 + con
      @character_data[:current_hp] = @character_data[:max_hp]
    end

    def calculate_max_load
      str = @character_data[:stats]["STR"] || 10
      @character_data[:max_load] = 12 + str
    end

    def calculate_current_load
      @character_data[:load] = calculate_total_weight
    end

    def add_starting_moves
      automatic_moves = @class_data["starting_moves"]["automatic"]

      automatic_moves.each do |move_id|
        move = find_move_by_id(move_id)
        @character_data[:moves] << move if move
      end
    end

    def select_racial_move(race)
      race ||= "human" # Default to human if not specified
      @character_data[:race] = race

      racial_move = get_racial_move(race)
      @character_data[:moves] << racial_move if racial_move
    end

    def select_alignment(alignment_key)
      alignment_key ||= "neutral" # Default to neutral
      alignment = get_alignment(alignment_key)
      @character_data[:alignment] = alignment if alignment
    end

    def select_gear(choices = {})
      gear_data = @class_data["gear"]

      # Add always-have items
      gear_data["always_have"].each do |item|
        @character_data[:gear] << item
      end

      # Defense choice (choose one)
      defense_choice = choices[:defense] || 0
      selected_defense = gear_data["choose_defense_one"][defense_choice]
      if selected_defense
        selected_defense["items"].each do |item|
          @character_data[:gear] << item
          @character_data[:armor] += item["armor"] if item["armor"]
          @character_data[:armor] += item["armor_bonus"] if item["armor_bonus"]
        end
      end

      # Choose two additional items
      chosen_indices = choices[:additional] || [ 0, 1 ]
      chosen_indices.each do |idx|
        item = gear_data["choose_two"][idx]
        if item
          if item["items"]
            # It's a group of items
            item["items"].each { |i| @character_data[:gear] << i }
          else
            # Single item
            @character_data[:gear] << item
            @character_data[:armor] += item["armor_bonus"] if item["armor_bonus"]
          end
        end
      end
    end

    def select_bonds(bond_choices = [])
      available_bonds = @class_data["bonds"]["options"]

      # Default to first 3 bonds if none specified
      bond_choices = [ 0, 1, 2 ] if bond_choices.empty?

      bond_choices.each do |idx|
        @character_data[:bonds] << available_bonds[idx] if available_bonds[idx]
      end
    end

    def customize_look(look_choices = {})
      look_categories = @class_data["hints"]["look"]["choose_one_each"]

      look_categories.each_with_index do |category, idx|
        choice_idx = look_choices[idx] || 0
        @character_data[:look]["category_#{idx}"] = category[choice_idx]
      end
    end

    def customize_signature_weapon(weapon_choices = {})
      weapon_data = @class_data["moves"]["level_1"].find { |m| m["id"] == "signature_weapon" }
      return unless weapon_data

      builder = weapon_data["builder"]

      # Base weapon
      base_idx = weapon_choices[:base] || 0
      base_weapon = builder["base_description"]["choose_one"][base_idx]

      # Enhancements
      enhancement_indices = weapon_choices[:enhancements] || [ 0, 1 ]
      enhancements = enhancement_indices.map do |idx|
        builder["enhancements"]["choose_two"][idx]
      end

      # Look
      look_idx = weapon_choices[:look] || 0
      weapon_look = builder["look"]["choose_one"][look_idx]

      signature_weapon = {
        base: base_weapon,
        enhancements: enhancements,
        look: weapon_look,
        weight: builder["base_description"]["weight"]
      }

      @character_data[:signature_weapon] = signature_weapon
    end

    def find_move_by_id(move_id)
      @class_data["moves"]["level_1"].find { |m| m["id"] == move_id }
    end
  end
end
