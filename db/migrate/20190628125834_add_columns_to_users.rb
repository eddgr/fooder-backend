class AddColumnsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :lat, :decimal
    add_column :users, :long, :decimal
  end
end
