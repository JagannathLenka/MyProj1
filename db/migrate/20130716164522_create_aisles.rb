class CreateAisles < ActiveRecord::Migration
  def change
    create_table :aisles do |t|
      t.string :zone_id
      t.string :aisle_id
      t.string :aisle_customerid
      t.string :properties1
      t.string :properties2
      t.string :properties3
      t.string :noof_bays

      t.timestamps
    end
  end
end
