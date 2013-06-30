class CreateAisles < ActiveRecord::Migration
  def change
    create_table :aisles do |t|
      t.string :aisle_id
      t.string :customer_aisle_id
      t.string :zone_id
      t.string :properties1
      t.string :properties2
      t.string :properties3

      t.timestamps
    end
  end
end
