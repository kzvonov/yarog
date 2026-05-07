class CreateIdentities < ActiveRecord::Migration[8.0]
  def change
    create_table :identities do |t|
      t.references :account, null: false, foreign_key: true
      t.integer :provider, null: false
      t.string :uid, null: false
      t.text :data

      t.timestamps
    end

    add_index :identities, [ :provider, :uid ], unique: true
  end
end
