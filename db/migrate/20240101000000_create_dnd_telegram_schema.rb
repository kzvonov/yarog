class CreateDndTelegramSchema < ActiveRecord::Migration[8.0]
  def change
    create_table :users do |t|
      t.bigint :telegram_id, null: false
      t.string :first_name
      t.string :last_name
      t.string :username

      t.timestamps
    end

    add_index :users, :telegram_id, unique: true

    create_table :game_templates do |t|
      t.string :name, null: false
      t.text :description, null: false
      t.text :hidden_description
      t.timestamps
    end

    create_table :locations do |t|
      t.references :game_template, index: false
      t.integer :x, null: false
      t.integer :y, null: false
      t.integer :location_type, default: 0
      t.string :name, null: false
      t.text :description, null: false
      t.text :hidden_description

      t.timestamps
    end

    add_index :locations, [ :game_template_id, :x, :y ], unique: true

    create_table :games do |t|
      t.references :game_template
      t.references :host
      t.string :join_code, null: false
      t.integer :status, default: 0
      t.integer :progress, default: 0

      t.timestamps
    end

    add_index :games, :join_code, unique: true

    create_table :characters do |t|
      t.references :user, null: false, foreign_key: true
      t.references :game_session
      t.references :location

      t.string :name, null: false
      t.integer :character_class, null: false
      t.integer :health, default: 10
      t.integer :max_health, default: 10
      t.integer :strength, default: 3
      t.integer :intelligence, default: 3
      t.integer :dexterity, default: 3
      t.boolean :has_eaten, default: true
      t.boolean :has_slept, default: true

      t.timestamps
    end
  end
end
