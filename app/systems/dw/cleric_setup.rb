require "json"
require_relative "base"

module Dw
  class ClericSetup
    attr_reader :character_data, :class_data

    def initialize
      @class_data = load_class_data
      reset_character_data
    end

    # Creates and saves a Cleric Hero to the database
    def create_cleric(name: nil, code: nil, options: {})
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
      select_deity(options[:deity] || {})
      select_gear(options[:gear_choices] || {})
      select_bonds(options[:bonds] || [])
      customize_look(options[:look] || {})
      select_starting_spells(options[:starting_spells] || {})
      calculate_current_load

      # Build Hero data structure
      hero_data = build_hero_data(name)

      # Create and save Hero (code will be auto-generated if nil)
      hero = Hero.new(
        code: code,
        specialization: "cleric",
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
    def preview_cleric(options = {})
      reset_character_data

      assign_stats(options[:stats] || suggested_stats)
      calculate_hp
      calculate_max_load
      add_starting_moves
      select_racial_move(options[:race])
      select_alignment(options[:alignment])
      select_deity(options[:deity] || {})
      select_gear(options[:gear_choices] || {})
      select_bonds(options[:bonds] || [])
      customize_look(options[:look] || {})
      select_starting_spells(options[:starting_spells] || {})
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

    def available_domains
      @class_data["deity"]["domains"]["choose_one"]
    end

    def available_precepts
      @class_data["deity"]["precepts"]["choose_one"]
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
      names.sample || "Cleric"
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
        look: {},
        deity: nil,
        domain: nil,
        precept: nil,
        spells: []
      }
    end

    def build_hero_data(name)
      {
        specialization: "cleric",
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
      parts << "На 7+: #{move['on_7_plus']}" if move["on_7_plus"]
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

      # Add weapons
      weapons = @character_data[:gear].select do |item|
        item.is_a?(Hash) && (item["item"]&.include?("молот") || item["item"]&.include?("Булава") ||
                             item["item"]&.include?("Посох") || item["tags"])
      end

      if weapons.any?
        equipment_lines << "Оружие:"
        weapons.each do |weapon|
          name = weapon["item"] || ""
          tags = weapon["tags"] ? " [#{weapon['tags'].join(', ')}]" : ""
          weight = weapon["weight"] ? " (#{weapon['weight']})" : ""
          equipment_lines << "- #{name}#{tags}#{weight}"
        end
      end

      # Separate gear into categories
      armor_items = []
      consumables = []
      holy_items = []
      other_items = []

      @character_data[:gear].each do |item|
        next unless item.is_a?(Hash)

        name = item["item"] || ""
        next if name.empty?

        # Skip weapons (already added above)
        next if weapons.include?(item)

        weight = item["weight"] ? " (#{item['weight']})" : ""
        armor_val = item["armor"] ? " [Броня: #{item['armor']}]" : ""
        armor_bonus = item["armor_bonus"] ? " [+#{item['armor_bonus']} броня]" : ""
        uses = item["uses"] ? " x#{item['uses']}" : ""
        desc = item["description"] ? " (#{item['description']})" : ""

        formatted_item = "#{name}#{uses}#{armor_val}#{armor_bonus}#{weight}#{desc}"

        # Categorize items
        if item["armor"] || item["armor_bonus"] || name.include?("броня") || name.include?("Щит")
          armor_items << formatted_item
        elsif name.include?("Символ") || name.include?("божества")
          holy_items << formatted_item
        elsif name.include?("Провизия") || name.include?("зелье") || name.include?("Пайки") ||
              name.include?("Бинты")
          consumables << formatted_item
        else
          other_items << formatted_item
        end
      end

      # Build equipment string
      equipment_lines << "\nБроня и защита:" if armor_items.any?
      equipment_lines.concat(armor_items.map { |item| "- #{item}" })

      equipment_lines << "\nСвятые предметы:" if holy_items.any?
      equipment_lines.concat(holy_items.map { |item| "- #{item}" })

      equipment_lines << "\nЗапасы и расходники:" if consumables.any?
      equipment_lines.concat(consumables.map { |item| "- #{item}" })

      equipment_lines << "\nПрочее снаряжение:" if other_items.any?
      equipment_lines.concat(other_items.map { |item| "- #{item}" })

      # Add spells section
      if @character_data[:spells].any?
        equipment_lines << "\nЗаклинания:"

        # Group by level
        rotes = @character_data[:spells].select { |s| s["level"] == "rote" }
        level_1 = @character_data[:spells].select { |s| s["level"] == 1 }

        if rotes.any?
          equipment_lines << "Заученные (Rotes):"
          rotes.each { |spell| equipment_lines << "- #{spell['name']}" }
        end

        if level_1.any?
          equipment_lines << "Уровень 1:"
          level_1.each { |spell| equipment_lines << "- #{spell['name']}" }
        end
      end

      # Add weight summary
      total_weight = calculate_total_weight
      equipment_lines << "\nОбщий вес: #{total_weight} / #{@character_data[:max_load]}"

      equipment_lines.join("\n")
    end

    def calculate_total_weight
      total = 0

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

      # Add deity info
      if @character_data[:deity]
        notes << "\nБожество: #{@character_data[:deity]}"
        notes << "Домен: #{@character_data[:domain]}" if @character_data[:domain]

        if @character_data[:precept]
          precept = @character_data[:precept]
          notes << "Заповедь: #{precept['name']} - #{precept['description']}"
        end
      end

      # Add bonds
      if @character_data[:bonds].any?
        notes << "\nУзы:"
        @character_data[:bonds].each { |bond| notes << "- #{bond}" }
      end

      notes.join("\n")
    end

    def load_class_data
      file_path = File.join(__dir__, "classes", "ru_cleric.json")
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
      @character_data[:max_hp] = 8 + con  # Cleric base HP is 8
      @character_data[:current_hp] = @character_data[:max_hp]
    end

    def calculate_max_load
      str = @character_data[:stats]["STR"] || 10
      @character_data[:max_load] = 10 + str  # Cleric base load is 10
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
      alignment_key ||= "good" # Default to good
      alignment = get_alignment(alignment_key)
      @character_data[:alignment] = alignment if alignment
    end

    def select_deity(deity_options = {})
      # Set deity name
      @character_data[:deity] = deity_options[:name] || random_deity_name

      # Select domain
      domain_idx = deity_options[:domain] || rand(available_domains.length)
      @character_data[:domain] = available_domains[domain_idx]

      # Select precept
      precept_idx = deity_options[:precept] || rand(available_precepts.length)
      @character_data[:precept] = available_precepts[precept_idx]
    end

    def random_deity_name
      deity_names = [
        "Тор", "Один", "Мория", "Пелор", "Баальзебуб",
        "Кор", "Морадин", "Корд", "Эрарис", "Нерулл"
      ]
      deity_names.sample
    end

    def select_gear(choices = {})
      gear_data = @class_data["gear"]

      # Add always-have items
      gear_data["always_have"].each do |item|
        @character_data[:gear] << item
      end

      # Defense choice (can choose multiple from options)
      defense_choices = choices[:defenses] || [0]
      defense_options = gear_data["choose_defenses"]["options"]

      defense_choices.each do |idx|
        item = defense_options[idx]
        if item
          @character_data[:gear] << item
          @character_data[:armor] += item["armor"] if item["armor"]
          @character_data[:armor] += item["armor_bonus"] if item["armor_bonus"]
        end
      end

      # Armament choice (choose one)
      armament_choice = choices[:armament] || 0
      selected_armament = gear_data["choose_armament_one"][armament_choice]
      if selected_armament
        if selected_armament["items"]
          # It's a group of items
          selected_armament["items"].each { |i| @character_data[:gear] << i }
        else
          # Single item
          @character_data[:gear] << selected_armament
        end
      end

      # Additional choice (choose one)
      additional_choice = choices[:additional] || 0
      selected_additional = gear_data["choose_one"][additional_choice]
      if selected_additional
        if selected_additional["items"]
          # It's a group of items
          selected_additional["items"].each { |i| @character_data[:gear] << i }
        else
          # Single item
          @character_data[:gear] << selected_additional
        end
      end
    end

    def select_bonds(bond_choices = [])
      available_bonds = @class_data["bonds"]["options"]

      # Default to first 3 bonds if none specified
      bond_choices = [0, 1, 2] if bond_choices.empty?

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

    def select_starting_spells(spell_choices = {})
      # Add all rote spells (always prepared)
      rotes = @class_data["spells"]["rotes"]
      @character_data[:spells].concat(rotes)

      # Select level 1 spells (can choose up to level+1 = 2 levels worth)
      # Default: choose 2 random level 1 spells
      level_1_spells = @class_data["spells"]["level_1"]
      chosen_indices = spell_choices[:level_1] || [0, 1]

      chosen_indices.each do |idx|
        spell = level_1_spells[idx]
        @character_data[:spells] << spell if spell
      end
    end

    def find_move_by_id(move_id)
      @class_data["moves"]["level_1"].find { |m| m["id"] == move_id }
    end
  end
end
