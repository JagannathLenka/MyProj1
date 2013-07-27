class CreateWarehouses < ActiveRecord::Migration
  def change
    create_table :warehouses do |t|
      t.string :client_id
      t.string :sm_warehouse_id
      t.string :cl_warehouse_id
      t.string :description
      t.integer :no_of_zones
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
