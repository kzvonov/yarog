class Hero < ApplicationRecord
  self.table_name = "heroes"

  has_many :logs, dependent: :destroy
  has_many :game_heroes, class_name: "GameHero", dependent: :destroy
  has_many :games, through: :game_heroes

  SPECIALIZATIONS = %w[warrior path_master rune_master evil_hunter fighter cleric bard].freeze

  validates :code, presence: true, uniqueness: true, format: { with: /\A[A-Za-z0-9]{6,8}\z/ }
  validates :specialization, presence: true, inclusion: { in: SPECIALIZATIONS }
  validates :name, presence: true
  validates :level, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1 }
  validates :xp, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :version, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  before_validation :generate_code, on: :create
  before_validation :set_defaults, on: :create

  # Parse data as JSON
  def hero_data
    @hero_data ||= JSON.parse(data)
  end

  def hero_data=(hash)
    @hero_data = hash
    self.data = hash.to_json
  end

  # Override reload to clear memoized data
  def reload(*)
    @hero_data = nil
    super
  end

  def calculate_diff(new_data)
    old_data = hero_data
    deep_diff(old_data, new_data)
  end

  def update_hero_data!(new_data)
    self.hero_data = new_data
    self.level = new_data["level"] if new_data["level"]
    self.xp = new_data["xp"] if new_data["xp"]
    self.version += 1
    save!
  end

  # Class methods for creating heroes
  class << self
    def create_warrior(name, code = nil)
      create_hero(
        name: name,
        code: code,
        specialization: "warrior",
        base_hp: 10,
        damage: "d10",
        stats: { str: 16, dex: 12, con: 15, int: 8, wis: 9, cha: 13 },
        moves: [
          { name: "Сокрушающий удар", desc: "Когда ты с силой рубишь, режешь или крушишь, брось+СИЛ. На 10+: наноси урон и выбери 1. На 7–9: наноси урон и выбери 1, но враг контратакует или ты попадаешь в опасную ситуацию." },
          { name: "В доспехах", desc: "Ты игнорируешь неуклюжесть доспехов, которые носишь." }
        ]
      )
    end

    def create_forest_walker(name, code = nil)
      create_hero(
        name: name,
        code: code,
        specialization: "forest_walker",
        base_hp: 8,
        damage: "d8",
        stats: { str: 13, dex: 16, con: 14, int: 9, wis: 15, cha: 8 },
        moves: [
          { name: "Выследить", desc: "Когда ты выслеживаешь цель в диких землях, брось+МДР. На 10+: ты находишь то, что ищешь. На 7–9: ты находишь следы, но выбери 1: это займёт время, ты привлечёшь внимание, или потеряешь что-то важное." },
          { name: "Меткий выстрел", desc: "Когда ты целишься и стреляешь в незащищённое место, брось+ЛОВ. На 10+: урон +1d6. На 7–9: урон +1d6, но выбери 1: ты тратишь боеприпасы, враг сближается, или ты попадаешь под ответный удар." }
        ]
      )
    end

    def create_rune_master(name, code = nil)
      create_hero(
        name: name,
        code: code,
        specialization: "rune_master",
        base_hp: 6,
        damage: "d6",
        stats: { str: 13, dex: 9, con: 15, int: 13, wis: 16, cha: 8 },
        moves: [
          { name: "Ритуал", desc: "Когда ты проводишь ритуал, скажи, чего хочешь добиться. Ведущий скажет, что потребуется: редкие компоненты, место силы, помощь, время, или жертва." },
          { name: "Начертить руну", desc: "Когда ты чертишь руну своей кровью, брось+ИНТ. На 10+: руна работает, как задумано. На 7–9: руна работает, но выбери 1: она требует больше крови (1d4 урона), она слабее, чем ожидалось, или она привлекает нежелательное внимание." }
        ]
      )
    end

    private

    def create_hero(name:, code:, specialization:, base_hp:, damage:, stats:, moves:)
      hero_data = {
        specialization: specialization,
        name: name,
        look: "",
        origin: "",
        level: 1,
        xp: 0,
        hpCurrent: base_hp + stats[:con],
        hpMax: base_hp + stats[:con],
        armor: 0,
        damage: damage,
        stats: stats,
        debilities: { str: false, dex: false, con: false, int: false, wis: false, cha: false },
        condition: "",
        moves: moves,
        equipment: "",
        notes: ""
      }

      hero = new(
        code: code,
        specialization: specialization,
        name: name,
        level: 1,
        xp: 0,
        data: hero_data.to_json,
        version: 0
      )

      hero.save!
      hero
    end
  end

  private

  def generate_code
    return if code.present?

    loop do
      self.code = SecureRandom.alphanumeric(6)
      break unless Hero.exists?(code: code)
    end
  end

  def set_defaults
    self.version ||= 0
    self.level ||= 1
    self.xp ||= 0
  end

  def values_different?(old_val, new_val)
    # Handle nil cases
    return true if old_val.nil? != new_val.nil?
    return false if old_val.nil? && new_val.nil?

    # For hashes, do deep comparison
    if old_val.is_a?(Hash) && new_val.is_a?(Hash)
      return true if old_val.keys.sort != new_val.keys.sort
      return old_val.any? { |k, v| values_different?(v, new_val[k]) }
    end

    # For arrays, do deep comparison
    if old_val.is_a?(Array) && new_val.is_a?(Array)
      return true if old_val.length != new_val.length
      return old_val.each_with_index.any? { |v, i| values_different?(v, new_val[i]) }
    end

    # For primitives, simple comparison
    old_val != new_val
  end

  def deep_diff(old_data, new_data, prefix = nil)
    diff = {}

    new_data.each do |key, new_value|
      old_value = old_data[key]
      current_key = prefix ? "#{prefix}.#{key}" : key

      # If both are hashes, recurse
      if old_value.is_a?(Hash) && new_value.is_a?(Hash)
        nested_diff = deep_diff(old_value, new_value, current_key)
        diff.merge!(nested_diff)
      # If both are arrays, compare them
      elsif old_value.is_a?(Array) && new_value.is_a?(Array)
        if old_value != new_value
          diff[current_key] = { "old" => old_value, "new" => new_value }
        end
      # For primitives, compare directly
      elsif old_value != new_value
        diff[current_key] = { "old" => old_value, "new" => new_value }
      end
    end

    diff
  end
end
