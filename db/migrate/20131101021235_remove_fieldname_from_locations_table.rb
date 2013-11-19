class RemoveFieldnameFromLocationsTable < ActiveRecord::Migration
  def up
    remove_column :locations, :location_priority
  end

  def down
    add_column :locations, :location_priority, :integer
  end
end
