class CreateBays < ActiveRecord::Migration
  def change
    create_table :bays do |t|
      t.string :bay_id
      t.string :aisle_id
      t.string :bay_customerid
      t.string :properties1
      t.string :properties2
      t.string :properties3
      t.string :noof_pos
      t.string :row_aisle

      t.timestamps
    end
  end
end
