class CreateWarehouses < ActiveRecord::Migration
  def change
    create_table :warehouses do |t|
      t.string :warehouse_id
      t.string :warehouse_customerid
      t.string :description
      t.string :properties1
      t.string :properties2
      t.string :properties3
      t.string :noof_zones

      t.timestamps
    end
  end
end
