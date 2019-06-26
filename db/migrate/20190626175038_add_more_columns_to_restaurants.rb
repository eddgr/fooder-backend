class AddMoreColumnsToRestaurants < ActiveRecord::Migration[5.2]
  def change
    add_column :restaurants, :fsq_id, :string
    add_column :restaurants, :integer, :string
    add_column :restaurants, :contact, :string
    add_column :restaurants, :location, :text
    add_column :restaurants, :categories, :string
    add_column :restaurants, :price, :string
    add_column :restaurants, :menu, :string
    add_column :restaurants, :hours, :string
    add_column :restaurants, :tip_text, :string
    add_column :restaurants, :tip_photo, :string
  end
end
