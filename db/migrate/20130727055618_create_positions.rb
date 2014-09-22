class CreatePositions < ActiveRecord::Migration
  def up
    create_table :positions do |t|
      t.string   "client_id"
      t.integer  "sm_pos_id"
      t.integer  "sm_level_id"
      t.integer  "sm_bay_id"
      t.integer  "sm_aisle_id"
      t.integer  "sm_zone_id"
      t.integer  "sm_warehouse_id"
      t.string   "sm_barcode"
      t.integer  "level_id"
      t.string   "cl_pos_id"
      t.string   "cl_level_id"
      t.string   "cl_bay_id"
      t.string   "cl_aisle_id"
      t.string   "cl_zone_id"
      t.string   "cl_warehouse_id"
      t.string   "cl_barcode"
      t.string   "description"
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

    t.timestamps
   end
  end
  
  def down
    drop_table :positions
  end
  
end
