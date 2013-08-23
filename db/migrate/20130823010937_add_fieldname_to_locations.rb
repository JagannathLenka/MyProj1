class AddFieldnameToLocations < ActiveRecord::Migration
  def change
    add_column :locations, :lock_code, :string
  end
end
