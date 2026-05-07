require "test_helper"

class IdentityTest < ActiveSupport::TestCase
  setup do
    @account = Account.create!(handle: "testuser")
  end

  test "valid identity" do
    identity = Identity.new(
      account: @account,
      provider: :telegram,
      uid: "123456789",
      data: { username: "testuser" }
    )
    assert identity.valid?
  end

  test "requires account" do
    identity = Identity.new(provider: :telegram, uid: "123456789")
    assert_not identity.valid?
    assert_includes identity.errors[:account], "must exist"
  end

  test "requires provider" do
    identity = Identity.new(account: @account, uid: "123456789")
    assert_not identity.valid?
    assert_includes identity.errors[:provider], "can't be blank"
  end

  test "requires uid" do
    identity = Identity.new(account: @account, provider: :telegram)
    assert_not identity.valid?
    assert_includes identity.errors[:uid], "can't be blank"
  end

  test "uid must be unique per provider" do
    Identity.create!(account: @account, provider: :telegram, uid: "123456789")

    duplicate = Identity.new(account: @account, provider: :telegram, uid: "123456789")
    assert_not duplicate.valid?
    assert_includes duplicate.errors[:uid], "has already been taken"
  end

  test "same uid allowed for different providers" do
    Identity.create!(account: @account, provider: :telegram, uid: "123456789")

    different_provider = Identity.new(account: @account, provider: :google, uid: "123456789")
    assert different_provider.valid?
  end

  test "enum providers" do
    assert_equal 0, Identity.providers[:telegram]
    assert_equal 1, Identity.providers[:email]
    assert_equal 2, Identity.providers[:google]
  end

  test "find_or_create_from_auth creates new account and identity" do
    assert_difference [ "Account.count", "Identity.count" ], 1 do
      identity = Identity.find_or_create_from_auth(
        :telegram,
        "987654321",
        { "username" => "johndoe" }
      )

      assert identity.persisted?
      assert_equal "telegram", identity.provider
      assert_equal "987654321", identity.uid
      assert_equal "johndoe", identity.account.handle
      assert_equal "johndoe", identity.data["username"]
    end
  end

  test "find_or_create_from_auth updates existing identity" do
    existing = Identity.create!(
      account: @account,
      provider: :telegram,
      uid: "111222333",
      data: { "username" => "oldname" }
    )

    assert_no_difference [ "Account.count", "Identity.count" ] do
      identity = Identity.find_or_create_from_auth(
        :telegram,
        "111222333",
        { "username" => "newname" }
      )

      assert_equal existing.id, identity.id
      assert_equal @account.id, identity.account_id
      assert_equal "newname", identity.data["username"]
    end
  end

  test "generates handle from telegram username" do
    identity = Identity.find_or_create_from_auth(
      :telegram,
      "123",
      { "username" => "shadowblade" }
    )
    assert_equal "shadowblade", identity.account.handle
  end

  test "generates handle from email" do
    identity = Identity.find_or_create_from_auth(
      :email,
      "alice@example.com",
      { "email" => "alice@example.com" }
    )
    assert_equal "alice", identity.account.handle
  end

  test "generates fantasy handle when no username" do
    identity = Identity.find_or_create_from_auth(
      :telegram,
      "456",
      { "first_name" => "John" }
    )
    assert_match(/\A[a-z]+_[a-z]+\z/, identity.account.handle)
  end
end
