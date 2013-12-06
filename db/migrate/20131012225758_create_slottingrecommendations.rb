class CreateSlottingrecommendations < ActiveRecord::Migration
  def up
    create_table :slottingrecommendations do |t|
      t.string   "client_id"
      t.string   "item_number"
      t.string   "preffered_zone"
      t.string   "preffered_aisle"
      t.string   "preffered_bay"
      t.string   "preffered_level"
      t.string   "preffered_position"
      t.string   "partial_slotting"
      t.string   "preffered_slotting_rules"
      t.string   "location_recommended"
      t.string   "slotting_status"
      t.string   "attribute1"
      t.string   "attribute2"
      t.string   "attribute3"
      t.string   "attribute4"
      t.string   "attribute5"
      t.string   "attribute6"
      t.string   "attribute7"
      t.string   "attribute8"
      t.string   "preffered_warehouse"
      t.integer  "quantity_to_be_slotted"

      t.timestamps
    end
  end
  
  def down
    drop_table :slottingrecommendations
  end

end
