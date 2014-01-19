class AddFieldnameToLocations < ActiveRecord::Migration
  def change
    add_column :locations, :location_length, :integer
    add_column :locations, :location_breadth, :integer
    add_column :locations, :location_height, :integer
    add_column :locations, :location_volume, :integer
    add_column :locations, :allowed_weight, :decimal
    add_column :locations, :item_short_description, :string
    add_column :locations, :item_long_description, :string
  end
end
