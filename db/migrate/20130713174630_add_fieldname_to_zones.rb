class AddFieldnameToZones < ActiveRecord::Migration
  def change
    add_column :zones, :nooflevel_aisle, :string
  end
end
