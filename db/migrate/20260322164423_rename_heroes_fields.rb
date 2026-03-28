class RenameHeroesFields < ActiveRecord::Migration[8.0]
  def change
    remove_column :heroes, :specialization, :string
    add_column :heroes, :klass, :integer, default: 0
    add_column :heroes, :origin, :integer, default: 0
  end
end
