class AddColumnToFavorites < ActiveRecord::Migration[5.2]
  def change
    add_column :favorites, :liked, :boolean
  end
end
