class Hero < ApplicationRecord
  self.table_name = "heroes"

  HP_BASE = 8
  STATS = {
    str: "str",
    dex: "dex",
    con: "con",
    int: "int",
    wis: "wis",
    cha: "cha"
  }.freeze

  enum :origin, {
    human: 0,
    dwarf: 1,
    elf: 2,
    dark_elf: 3,
    high_elf: 4,
    gnome: 5,
    orc: 6,
    troll: 7,
    goblin: 8,
    tauren: 9,
    tiefling: 10,
    frog_folk: 11,
    turtle_folk: 12,
    # homebrew
    yar_human: 30,
    yar_dog_folk: 31,
    yar_elf: 32
  }, prefix: true

  enum :klass, {
    bard: 0,
    priest: 1,
    druid: 2,
    fighter: 3,
    paladin: 4,
    ranger: 5,
    thief: 6,
    wizard: 7,
    # homebrew
    yar_berserk: 30,
    yar_path_master: 31,
    yar_rune_master: 32,
    yar_evil_hunter: 33
  }, prefix: true

  store :data, accessors: [
    :hp_current, :damage, :armor, :coins, :weapons, :equipment, :bonds, :notes, :look, :moves,
    *STATS.values.map { "stat_#{it}".to_sym },
    *STATS.values.map { "deb_#{it}".to_sym }
  ], coder: JSON

  has_many :logs, dependent: :destroy
  has_many :game_heroes, class_name: "GameHero", dependent: :destroy
  has_many :games, through: :game_heroes

  validates :code, presence: true, uniqueness: true, format: { with: /\A[A-Za-z0-9]{6,8}\z/ }
  validates :name, presence: true
  validates :level, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1 }
  validates :xp, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :version, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  before_validation :generate_code, on: :create
  before_validation :set_defaults, on: :create

  def self.calculate_dice_mod(value)
    case value.to_i
    when ..3
      -3
    when 4..5
      -2
    when 6..8
      -1
    when 9..12
      0
    when 13..15
      1
    when 16..17
      2
    else
      3
    end
  end

  def dice_mod(stat_name)
    stat_key = "stat_#{stat_name}"
    deb_key = "deb_#{stat_name}"
    stat_value = data[stat_key].to_i
    deb_value = data[deb_key] == true ? 1 : 0

    dice_mod = Hero.calculate_dice_mod(stat_value)
    dice_mod - deb_value
  end

  def hp_max
    HP_BASE + stat_con.to_i
  end

  STATS.each do |stat_key, _|
    define_method("dice_mod_#{stat_key}") { dice_mod(stat_key) }
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
end
