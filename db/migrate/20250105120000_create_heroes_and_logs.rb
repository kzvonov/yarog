class CreateHeroesAndLogs < ActiveRecord::Migration[7.1]
  def change
    create_table :heroes do |t|
      t.string :code, null: false, index: { unique: true }
      t.string :specialization, null: false
      t.string :name, null: false
      t.integer :level, null: false, default: 1
      t.integer :xp, null: false, default: 0
      t.text :data, null: false
      t.integer :version, null: false, default: 0

      t.timestamps
    end

    create_table :logs do |t|
      t.integer :hero_id, null: false
      t.string :log_type, null: false
      t.text :data, null: false

      t.timestamps
    end

    add_index :logs, :hero_id
    add_index :logs, [:hero_id, :created_at]
    add_index :logs, :log_type
  end
end
