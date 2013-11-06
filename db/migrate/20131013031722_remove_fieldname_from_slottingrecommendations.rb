class RemoveFieldnameFromSlottingrecommendations < ActiveRecord::Migration
  def up
    remove_column :slottingrecommendations, :quanttity_to_be_slotted
  end

  def down
    add_column :slottingrecommendations, :quanttity_to_be_slotted, :integer
  end
end
