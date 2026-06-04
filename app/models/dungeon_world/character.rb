module DungeonWorld
  class Character < ::Character
    STATS = %w[str dex con int wis cha].freeze

    Move = Data.define(:name, :description, :level, :type) do
      def initialize(name:, description:, level: 0, type: "-")
        super(name:, description:, level:, type:)
      end
    end

    # enum :origin, Origin.enum, prefix: true
    # enum :klass, Klass.enum, prefix: true

    store :vitals, accessors: [ :hp_current, :hp_max, :armor, :damage, :xp, :coins ] + STATS, coder: JSON
    store :inventory, accessors: [], coder: JSON
    store :abilities, accessors: [ :moves, :spellbook ], coder: JSON
    store :story, accessors: [], coder: JSON

    validates :origin, inclusion: { in: Origin.list }
    validates :klass, inclusion: { in: Klass.list }

    def self.enabled? = true

    def forge
      raise "character(#{self.id}) already saved" if persisted?
      Forge.call(self)
    end

    def hp_max
      vitals["hp_max"] || (8 + stat_value(:con))
    end

    def xp_to_next_level
      (level || 1) + 7
    end

    def level_max
      10
    end

    def stat_modifier(stat)
      value = vitals.dig(stat.to_s)&.to_i || 1
      Helper.stat_modifier(value)
    end

    def roll_dice(stat)
      modifier = stat_modifier(stat)
      dice = [ rand(1..6), rand(1..6) ]
      total = dice.sum + modifier

      {
        dice: dice,
        modifier: modifier,
        total: total,
        result: interpret_result(total)
      }
    end

    def interpret_result(total)
      case total
      when ..6 then "miss"
      when 7..9 then "partial"
      else "success"
      end
    end

    def prepared_moves
      moves.map do |move|
        case move
        when String
          sub_path = move.split(":").join(".")
          Move.new(**I18n.t("dungeon_world.#{sub_path}"))
        when Hash
          Move.new(**move)
        end
      end
    end

    def show_view
      "/dw/show"
    end
  end
end
