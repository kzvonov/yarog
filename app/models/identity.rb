class Identity < ApplicationRecord
  serialize :data, coder: JSON

  enum :provider, { telegram: 0, email: 1, google: 2 }

  belongs_to :account

  validates :provider, presence: true
  validates :uid, presence: true, uniqueness: { scope: :provider }

  def self.find_or_create_from_auth!(provider, uid, auth_data = {})
    identity = find_or_initialize_by(provider: provider, uid: uid)

    if identity.new_record?
      identity.data = auth_data
      ActiveRecord::Base.transaction do
        handle = HandleGenerator.generate_for(identity)
        identity.account = Account.create!(handle: handle)
        identity.save!
      end
    else
      identity.update!(data: auth_data)
    end

    identity
  end

  def summary
    case provider.to_sym
    when :telegram
      [
        data["username"],
        data.slice("first_name", "last_name").values.join(" ").strip,
        data["language_code"],
        created_at
      ].compact.join(" / ")
    else
      "not implemented"
    end
  end
end
