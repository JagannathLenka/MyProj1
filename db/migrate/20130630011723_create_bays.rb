class CreateBays < ActiveRecord::Migration
  def change
    create_table :bays do |t|
      t.string :bay_id
      t.string :customer_bay_id
      t.string :aisle_id
      t.string :properties1
      t.string :properties2
      t.string :properties3

      t.timestamps
    end
  end
end
