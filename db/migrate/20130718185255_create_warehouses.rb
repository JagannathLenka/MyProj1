class CreateWarehouses < ActiveRecord::Migration
  def change
    create_table :warehouses do |t|
      t.string :client_id
      t.string :sm_warehouse_id
      t.string :cl_warehouse_id
      t.string :description
      t.string :no_of_zones
      t.string :atrribute1
      t.string :atrribute2
      t.string :atrribute3
      t.string :atrribute4
      t.string :atrribute5
      t.string :atrribute6
      t.string :atrribute7
      t.string :atrribute8

      t.timestamps
    end
  end
end
