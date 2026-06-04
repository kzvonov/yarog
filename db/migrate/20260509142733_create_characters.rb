class CreateCharacters < ActiveRecord::Migration[8.1]
  def change
    create_table :characters do |t|
      t.references :account, null: false
      t.string :type, null: false

      t.string :name, null: false
      t.string :origin, null: false
      t.string :klass, null: false

      t.integer :level, null: false, default: 1
      t.integer :xp, null: false, default: 0
      t.string :avatar_url

      t.text :vitals, null: false
      t.text :inventory, null: false
      t.text :abilities, null: false
      t.text :story, null: false

      t.timestamps
    end
  end
end
