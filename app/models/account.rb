class Account < ApplicationRecord
  has_many :identities, dependent: :destroy
  has_many :sessions, dependent: :destroy

  validates :handle, presence: true, uniqueness: true

  def self.find_by_identity(provider, uid)
    joins(:identities).find_by(identities: { provider: provider, uid: uid })
  end

  def has_provider?(provider)
    identities.exists?(provider: provider)
  end

  def identity_for(provider)
    identities.find_by(provider: provider)
  end
end
