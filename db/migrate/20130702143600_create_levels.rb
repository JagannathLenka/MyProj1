class CreateLevels < ActiveRecord::Migration
  def change
    create_table :levels do |t|
      t.string :level_id
      t.string :customerlevel_id
      t.string :bay_id
      t.string :properties1
      t.string :properties2
      t.string :properties3

      t.timestamps
    end
  end
end
