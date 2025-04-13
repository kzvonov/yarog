class Game < ApplicationRecord
  belongs_to :game_template
  belongs_to :host, class_name: "User"
  has_many :characters, dependent: :destroy
  has_many :users, through: :characters
  has_many :game_events, dependent: :destroy
  has_one :turn_tracker, dependent: :destroy

  validates :join_code, presence: true, uniqueness: true

  enum status: { waiting: 0, active: 1, completed: 2 }
  enum progress: { village: 0, traveling: 1, shelter: 2, completed: 3 }

  # Generate a unique join code
  before_validation :generate_join_code, on: :create

  private

  def generate_join_code
    self.join_code ||= SecureRandom.alphanumeric(6).upcase
  end
end
