class User < ApplicationRecord
  has_many :characters, dependent: :destroy
  has_many :hosted_games, class_name: "Game", foreign_key: "host_id", dependent: :destroy

  validates :telegram_id, presence: true, uniqueness: true
end
