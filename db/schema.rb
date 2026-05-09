# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.1].define(version: 2026_05_04_071131) do
  create_table "accounts", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "handle", null: false
    t.string "locale", default: "en", null: false
    t.string "theme", default: "auto", null: false
    t.datetime "updated_at", null: false
    t.index ["handle"], name: "index_accounts_on_handle", unique: true
  end

  create_table "game_heroes", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "game_id", null: false
    t.integer "game_index"
    t.integer "hero_id", null: false
    t.datetime "updated_at", null: false
    t.index ["game_id", "hero_id"], name: "index_game_heroes_on_game_id_and_hero_id", unique: true
    t.index ["game_id"], name: "index_game_heroes_on_game_id"
  end

  create_table "games", force: :cascade do |t|
    t.boolean "active", default: false, null: false
    t.string "ambient_music_url"
    t.datetime "created_at", null: false
    t.string "name", null: false
    t.text "notes"
    t.datetime "updated_at", null: false
  end

  create_table "hero_templates", force: :cascade do |t|
    t.integer "armor", default: 0, null: false
    t.integer "base_hp", default: 6, null: false
    t.string "code", null: false
    t.datetime "created_at", null: false
    t.string "damage", default: "d6", null: false
    t.text "data", null: false
    t.integer "level", default: 1, null: false
    t.text "moves", null: false
    t.string "title", null: false
    t.datetime "updated_at", null: false
    t.index ["code"], name: "index_hero_templates_on_code", unique: true
  end

  create_table "heroes", force: :cascade do |t|
    t.string "code", null: false
    t.datetime "created_at", null: false
    t.text "data", null: false
    t.integer "klass", default: 0
    t.integer "level", default: 1, null: false
    t.string "name", null: false
    t.integer "origin", default: 0
    t.datetime "updated_at", null: false
    t.integer "version", default: 0, null: false
    t.integer "xp", default: 0, null: false
    t.index ["code"], name: "index_heroes_on_code", unique: true
  end

  create_table "identities", force: :cascade do |t|
    t.integer "account_id", null: false
    t.datetime "created_at", null: false
    t.text "data"
    t.integer "provider", null: false
    t.string "uid", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_identities_on_account_id"
    t.index ["provider", "uid"], name: "index_identities_on_provider_and_uid", unique: true
  end

  create_table "logs", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.text "data", null: false
    t.integer "game_id"
    t.integer "hero_id", null: false
    t.string "log_type", null: false
    t.datetime "updated_at", null: false
    t.index ["game_id", "id"], name: "index_logs_on_game_id_and_id", order: { id: :desc }
    t.index ["hero_id", "created_at"], name: "index_logs_on_hero_id_and_created_at"
    t.index ["hero_id"], name: "index_logs_on_hero_id"
    t.index ["log_type"], name: "index_logs_on_log_type"
  end

  create_table "sessions", force: :cascade do |t|
    t.integer "account_id", null: false
    t.datetime "created_at", null: false
    t.string "ip_address"
    t.datetime "updated_at", null: false
    t.string "user_agent"
    t.index ["account_id"], name: "index_sessions_on_account_id"
  end

  add_foreign_key "game_heroes", "games"
  add_foreign_key "game_heroes", "heroes"
  add_foreign_key "identities", "accounts"
  add_foreign_key "sessions", "accounts"
end
