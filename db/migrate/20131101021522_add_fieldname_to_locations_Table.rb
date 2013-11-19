class AddFieldnameToLocationsTable < ActiveRecord::Migration
  def change
    add_column :locations, :location_priority, :string
  end
end
