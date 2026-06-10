class Character < ApplicationRecord
  belongs_to :account

  store :vitals, accessors: [], coder: JSON
  store :inventory, accessors: [], coder: JSON
  store :abilities, accessors: [], coder: JSON
  store :story, accessors: [], coder: JSON

  validates :origin, presence: true
  validates :klass, presence: true
  validates :name, presence: true
  validates :level, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1 }
  validates :xp, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  before_validation :set_defaults, on: :create

  def enabled? = false

  def system
    return if type.nil?

    self.class.module_parent
  end

  def hp_max
    raise NotImplementedError, "Subclass must implement hp_max"
  end

  def hp_current
    vitals["hp_current"] || hp_max
  end

  def show_view
    raise "not implemented"
  end

  def card_description
    [ self.klass, self.origin ].join(" · ")
  end

  private

  def set_defaults
    self.level ||= 1
    self.xp ||= 0
    self.vitals ||= {}
    self.inventory ||= {}
    self.abilities ||= {}
    self.story ||= {}
  end
end
