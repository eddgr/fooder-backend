class AddColumnsToRestaurants < ActiveRecord::Migration[5.2]
  def change
    add_column :restaurants, :lat, :decimal
    add_column :restaurants, :long, :decimal
  end
end
