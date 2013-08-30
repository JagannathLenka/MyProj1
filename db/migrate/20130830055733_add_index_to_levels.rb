class AddIndexToLevels < ActiveRecord::Migration
  def change
    add_index :levels , :bay_id
  end
end
