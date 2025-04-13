class Location < ApplicationRecord
  belongs_to :game_template, optional: true
  has_many :characters, dependent: :nullify
  has_many :items, as: :itemable
  has_many :clues, dependent: :destroy

  validates :name, presence: true
  validates :description, presence: true
  validates :x, :y, presence: true, if: :game_template_id?

  enum location_type: {
    village: 0,
    path: 1,
    shelter: 2,
    encounter: 3
  }

  # Check if location is safe for rest
  def safe_for_rest?
    location_type == "village" || location_type == "shelter"
  end

  # Ensure uniqueness of x,y coordinates within a game_template
  validates :x, uniqueness: { scope: [ :game_template_id, :y ] }, if: :game_template_id?
end
