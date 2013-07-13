class CreateZones < ActiveRecord::Migration
  def change
    create_table :zones do |t|
      t.string :zone_id
      t.string :zone_customerid
      t.string :warehouse_id
      t.string :description
      t.string :noofaisles_zone
      t.string :noofbays_aisle
      t.string :properties1
      t.string :properties2
      t.string :properties3

      t.timestamps
    end
  end
end
