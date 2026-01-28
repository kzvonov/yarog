class CreateHeroTemplates < ActiveRecord::Migration[8.0]
  def change
    create_table :hero_templates do |t|
      t.string :title, null: false
      t.string :code, null: false
      t.integer :level, null: false, default: 1
      t.integer :base_hp, null: false, default: 6
      t.integer :armor, null: false, default: 0
      t.string :damage, null: false, default: "d6"

      t.text :moves, null: false
      t.text :data, null: false

      t.timestamps
    end

    add_index :hero_templates, :code, unique: true
  end
end
