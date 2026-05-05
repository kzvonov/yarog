require "test_helper"

class AccountTest < ActiveSupport::TestCase
  test "valid account" do
    account = Account.new(handle: "sharp_blade")
    assert account.valid?
  end

  test "requires handle" do
    account = Account.new
    assert_not account.valid?
    assert_includes account.errors[:handle], "can't be blank"
  end

  test "handle must be unique" do
    Account.create!(handle: "existinguser")

    duplicate = Account.new(handle: "existinguser")
    assert_not duplicate.valid?
    assert_includes duplicate.errors[:handle], "has already been taken"
  end

  test "has many identities" do
    account = Account.create!(handle: "testuser")

    identity1 = Identity.create!(account: account, provider: :telegram, uid: "123", data: {})
    identity2 = Identity.create!(account: account, provider: :google, uid: "456", data: {})

    assert_equal 2, account.identities.count
    assert_includes account.identities, identity1
    assert_includes account.identities, identity2
  end

  test "destroys dependent identities" do
    account = Account.create!(handle: "testuser")
    Identity.create!(account: account, provider: :telegram, uid: "123", data: {})
    Identity.create!(account: account, provider: :google, uid: "456", data: {})

    assert_difference "Identity.count", -2 do
      account.destroy
    end
  end

  test "find_by_identity finds account by telegram" do
    account = Account.create!(handle: "telegramuser")
    Identity.create!(account: account, provider: :telegram, uid: "987654", data: {})

    found = Account.find_by_identity(:telegram, "987654")
    assert_equal account.id, found.id
  end

  test "find_by_identity finds account by email" do
    account = Account.create!(handle: "emailuser")
    Identity.create!(account: account, provider: :email, uid: "user@example.com", data: {})

    found = Account.find_by_identity(:email, "user@example.com")
    assert_equal account.id, found.id
  end

  test "find_by_identity returns nil when not found" do
    found = Account.find_by_identity(:telegram, "nonexistent")
    assert_nil found
  end

  test "has_provider? returns true when provider exists" do
    account = Account.create!(handle: "testuser")
    Identity.create!(account: account, provider: :telegram, uid: "123", data: {})

    assert account.has_provider?(:telegram)
  end

  test "has_provider? returns false when provider does not exist" do
    account = Account.create!(handle: "testuser")
    Identity.create!(account: account, provider: :telegram, uid: "123", data: {})

    assert_not account.has_provider?(:google)
  end

  test "identity_for returns identity for given provider" do
    account = Account.create!(handle: "testuser")
    telegram_identity = Identity.create!(account: account, provider: :telegram, uid: "123", data: {})

    found = account.identity_for(:telegram)
    assert_equal telegram_identity.id, found.id
  end

  test "identity_for returns nil when provider not found" do
    account = Account.create!(handle: "testuser")

    found = account.identity_for(:google)
    assert_nil found
  end
end
