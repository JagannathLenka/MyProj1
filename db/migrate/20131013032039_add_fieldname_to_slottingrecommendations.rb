class AddFieldnameToSlottingrecommendations < ActiveRecord::Migration
  def change
    add_column :slottingrecommendations, :quantity_to_be_slotted, :integer
  end
  
end
