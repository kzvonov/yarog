class Account < ApplicationRecord
  MAX_CHARACTERS = 5

  enum :locale, { en: "en", ru: "ru" }, validate: true
  enum :theme, { auto: "auto", day: "day", night: "night" }, validate: true

  has_many :identities, dependent: :destroy
  has_many :sessions, dependent: :destroy
  has_many :characters, dependent: :destroy

  validates :handle, presence: true, uniqueness: true
  validate :characters_limit

  def self.find_by_identity(provider, uid)
    joins(:identities).find_by(identities: { provider: provider, uid: uid })
  end

  def has_provider?(provider)
    identities.exists?(provider: provider)
  end

  def identity_for(provider)
    identities.find_by(provider: provider)
  end

  private

  def characters_limit
    if characters.size >= MAX_CHARACTERS
      errors.add(:characters, "cannot exceed #{MAX_CHARACTERS} characters")
    end
  end
end
