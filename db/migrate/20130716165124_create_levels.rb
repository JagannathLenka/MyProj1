class CreateLevels < ActiveRecord::Migration
  def change
    create_table :levels do |t|
      t.string :level_id
      t.string :level_customerid
      t.string :properties1
      t.string :properties2
      t.string :properties3
      t.string :zone_id

      t.timestamps
    end
  end
end
