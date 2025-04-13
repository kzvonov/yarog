class GameTemplate < ApplicationRecord
  has_many :locations, dependent: :destroy
  has_many :games, dependent: :destroy

  validates :name, presence: true
  validates :description, presence: true
end
