require "test_helper"

class HandleGeneratorTest < ActiveSupport::TestCase
  setup do
    @account = Account.create!(handle: "existinguser")
  end

  test "generates handle from telegram username" do
    identity = Identity.new(
      provider: :telegram,
      uid: "123",
      data: { "username" => "ShadowBlade" }
    )

    handle = HandleGenerator.generate_for(identity)
    assert_equal "shadowblade", handle
  end

  test "generates handle from email prefix" do
    identity = Identity.new(
      provider: :email,
      uid: "alice@example.com",
      data: { "email" => "alice@example.com" }
    )

    handle = HandleGenerator.generate_for(identity)
    assert_equal "alice", handle
  end

  test "generates handle from google email" do
    identity = Identity.new(
      provider: :google,
      uid: "google-123",
      data: { "email" => "bob@gmail.com" }
    )

    handle = HandleGenerator.generate_for(identity)
    assert_equal "bob", handle
  end

  test "generates fantasy handle for telegram without username" do
    identity = Identity.new(
      provider: :telegram,
      uid: "456",
      data: { "first_name" => "John" }
    )

    handle = HandleGenerator.generate_for(identity)
    assert_match(/\A[a-z]+_[a-z]+\z/, handle)
  end

  test "generates fantasy handle when email missing" do
    identity = Identity.new(
      provider: :google,
      uid: "google-456",
      data: {}
    )

    handle = HandleGenerator.generate_for(identity)
    assert_match(/\A[a-z]+_[a-z]+\z/, handle)
  end

  test "cleans special characters from handle" do
    identity = Identity.new(
      provider: :telegram,
      uid: "789",
      data: { "username" => "User-Name.123!" }
    )

    handle = HandleGenerator.generate_for(identity)
    assert_equal "username123", handle
  end

  test "lowercases handle" do
    identity = Identity.new(
      provider: :telegram,
      uid: "999",
      data: { "username" => "UpperCase" }
    )

    handle = HandleGenerator.generate_for(identity)
    assert_equal "uppercase", handle
  end

  test "appends code when handle is taken" do
    Account.create!(handle: "alice")

    identity = Identity.new(
      provider: :email,
      uid: "alice@example.com",
      data: { "email" => "alice@example.com" }
    )

    handle = HandleGenerator.generate_for(identity)
    assert_match(/\Aalice_\d{4}\z/, handle)
  end

  test "retries until unique handle found" do
    Account.create!(handle: "bob")
    Account.create!(handle: "bob_0000")
    Account.create!(handle: "bob_0001")

    identity = Identity.new(
      provider: :email,
      uid: "bob@example.com",
      data: { "email" => "bob@example.com" }
    )

    handle = HandleGenerator.generate_for(identity)
    assert_match(/\Abob_\d{4}\z/, handle)
    assert_not_equal "bob_0000", handle
    assert_not_equal "bob_0001", handle
  end

  test "fantasy handle uses adjective and profession" do
    identity = Identity.new(
      provider: :telegram,
      uid: "111",
      data: {}
    )

    handle = HandleGenerator.generate_for(identity)
    parts = handle.split("_")

    assert_equal 2, parts.length
    assert_includes HandleGenerator::ADJECTIVES, parts[0]
    assert_includes HandleGenerator::PROFESSIONS, parts[1]
  end

  test "preserves underscores in username" do
    identity = Identity.new(
      provider: :telegram,
      uid: "222",
      data: { "username" => "shadow_blade" }
    )

    handle = HandleGenerator.generate_for(identity)
    assert_equal "shadow_blade", handle
  end
end
