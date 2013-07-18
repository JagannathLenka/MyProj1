class CreatePositions < ActiveRecord::Migration
  def change
    create_table :positions do |t|
      t.string :pos_id
      t.string :pos_customerid
      t.string :bay_id
      t.string :level_id
      t.string :properties1
      t.string :properties2
      t.string :properties3

      t.timestamps
    end
  end
end
