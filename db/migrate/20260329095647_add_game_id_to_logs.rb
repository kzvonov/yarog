class AddGameIdToLogs < ActiveRecord::Migration[8.0]
  def change
    add_column :logs, :game_id, :integer, null: true
    add_index :logs, [ :game_id, :id ], order: { id: :desc }
  end
end
