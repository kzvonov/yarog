class CreateAccounts < ActiveRecord::Migration[8.0]
  def change
    create_table :accounts do |t|
      t.string :handle, null: false
      t.string :locale, null: false, default: "en"
      t.string :theme, null: false, default: "auto"

      t.timestamps
    end
    add_index :accounts, :handle, unique: true
  end
end
