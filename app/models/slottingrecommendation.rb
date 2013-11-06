class Slottingrecommendation < ActiveRecord::Base
  attr_accessible :attribute1, :attribute2, :attribute3, :attribute4, :attribute5, :attribute6, :attribute7, :attribute8, :client_id, :item_number, :location_recommended, :partial_slotting, :preffered_aisle, :preffered_bay, :preffered_level, :preffered_position, :preffered_slotting_rules, :preffered_warehouse, :preffered_zone, :quantity_to_be_slotted, :slotting_status
end
