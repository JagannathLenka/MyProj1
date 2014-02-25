class CreateSlottingWaves < ActiveRecord::Migration
  def change
    create_table :slotting_waves do |t|
      t.string :client_id
      t.string :wave_number
      t.string :preffered_warehouse
      t.string :preffered_zone
      t.string :preffered_aisle
      t.string :preffered_bay
      t.string :preffered_level
      t.string :preffered_position
      t.string :preffered_slotting_rules
      t.string :wave_status
      t.string :attribute1
      t.string :attribute2
      t.string :attribute3
      t.string :attribute4
      t.string :attribute5
      t.string :attribute6
      t.string :attribute7
      t.string :attribute8

      t.timestamps
    end
  end
  
 def down
   drop_table :slotting_waves
 end
 
end
