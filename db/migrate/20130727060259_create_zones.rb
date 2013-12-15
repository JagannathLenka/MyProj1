class CreateZones < ActiveRecord::Migration
  def up
    create_table :zones do |t|
      t.string   "client_id"
      t.integer  "sm_zone_id"
      t.integer  "sm_warehouse_id"
      t.integer  "warehouse_id"
      t.string   "cl_zone_id"
      t.string   "cl_warehouse_id"
      t.string   "description"
      t.integer  "no_of_aisles_zone"
      t.integer  "no_of_bays_aisle"
      t.integer  "no_of_levels_aisle"
      t.string   "attribute1"
      t.string   "attribute2"
      t.string   "attribute3"
      t.string   "attribute4"
      t.string   "attribute5"
      t.string   "attribute6"
      t.string   "attribute7"
      t.string   "attribute8"

      t.timestamps
    end
  end
  
  def down
    drop_table :zones
  end  
end
