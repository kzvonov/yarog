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

ActiveRecord::Schema[8.0].define(version: 2024_01_01_000000) do
  create_table "characters", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "game_session_id"
    t.integer "location_id"
    t.string "name", null: false
    t.integer "character_class", null: false
    t.integer "health", default: 10
    t.integer "max_health", default: 10
    t.integer "strength", default: 3
    t.integer "intelligence", default: 3
    t.integer "dexterity", default: 3
    t.boolean "has_eaten", default: true
    t.boolean "has_slept", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_session_id"], name: "index_characters_on_game_session_id"
    t.index ["location_id"], name: "index_characters_on_location_id"
    t.index ["user_id"], name: "index_characters_on_user_id"
  end

  create_table "game_templates", force: :cascade do |t|
    t.string "name", null: false
    t.text "description", null: false
    t.text "hidden_description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "games", force: :cascade do |t|
    t.integer "game_template_id"
    t.integer "host_id"
    t.string "join_code", null: false
    t.integer "status", default: 0
    t.integer "progress", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_template_id"], name: "index_games_on_game_template_id"
    t.index ["host_id"], name: "index_games_on_host_id"
    t.index ["join_code"], name: "index_games_on_join_code", unique: true
  end

  create_table "locations", force: :cascade do |t|
    t.integer "game_template_id"
    t.integer "x", null: false
    t.integer "y", null: false
    t.integer "location_type", default: 0
    t.string "name", null: false
    t.text "description", null: false
    t.text "hidden_description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_template_id", "x", "y"], name: "index_locations_on_game_template_id_and_x_and_y", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.bigint "telegram_id", null: false
    t.string "first_name"
    t.string "last_name"
    t.string "username"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["telegram_id"], name: "index_users_on_telegram_id", unique: true
  end

  add_foreign_key "characters", "users"
end
