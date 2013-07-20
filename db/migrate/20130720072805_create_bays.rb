class CreateBays < ActiveRecord::Migration
  def change
    create_table :bays do |t|
      t.string :client_id
      t.string :sm_bay_id
      t.string :sm_aisle_id
      t.string :sm_zone_id
      t.string :sm_warehouse_id
      t.string :aisle_id
      t.string :cl_bay_id
      t.string :cl_aisle_id
      t.string :cl_zone_id
      t.string :cl_warehouse_id
      t.string :description
      t.string :no_of_level_bay
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
end
