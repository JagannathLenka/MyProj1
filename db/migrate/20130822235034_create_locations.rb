class CreateLocations < ActiveRecord::Migration
  def up
    create_table :locations do |t|
    
      t.string   "client_id"
      t.integer  "sm_loc_id"
      t.integer  "sm_pos_id"
      t.integer  "sm_level_id"
      t.integer  "sm_bay_id"
      t.integer  "sm_aisle_id"
      t.integer  "sm_zone_id"
      t.integer  "sm_warehouse_id"
      t.string   "sm_barcode"
      t.string   "cl_loc_id"
      t.string   "cl_pos_id"
      t.string   "cl_level_id"
      t.string   "cl_bay_id"
      t.string   "cl_aisle_id"
      t.string   "cl_zone_id"
      t.string   "cl_warehouse_id"
      t.string   "cl_barcode"
      t.string   "current_item"
      t.integer  "current_quantity"
      t.integer  "minimum_quantity"
      t.integer  "maximum_quantity"
      t.string   "status"
      t.integer  "life_time_total_picks"
      t.string   "attribute1"
      t.string   "attribute2"
      t.string   "attribute3"
      t.string   "attribute4"
      t.string   "attribute5"
      t.string   "attribute6"
      t.string   "attribute7"
      t.string   "attribute8"
      t.string   "attribute9"
      t.string   "attribute10"
      t.string   "attribute11"
      t.string   "attribute12"
      t.string   "attribute13"
      t.string   "attribute14"
      t.string   "attribute15"
      t.string   "attribute16"
      t.string   "lock_code"
      t.string   "location_priority"
  
      t.timestamps

  end
end
  
  def down
    drop_table :locations
  end
end