class CreateWarehouses < ActiveRecord::Migration
  def change
    create_table :warehouses do |t|
      t.string :warehouse_id
      t.string :descripton
      t.string :noof_zones
      t.string :properties1
      t.string :properties2
      t.string :properties3

      t.timestamps
    end
  end
end
