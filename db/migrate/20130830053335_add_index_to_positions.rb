class AddIndexToPositions < ActiveRecord::Migration
  def change
    add_index :positions , :level_id
  end
end
