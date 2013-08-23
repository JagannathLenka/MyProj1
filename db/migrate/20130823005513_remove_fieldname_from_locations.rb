class RemoveFieldnameFromLocations < ActiveRecord::Migration
  def up
    remove_column :locations, :level_id
    remove_column :locations, :lock_code
  end

  def down
    add_column :locations, :lock_code, :integer
    add_column :locations, :level_id, :string
  end
end
