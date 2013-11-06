class Location < ActiveRecord::Base
  attr_accessible :attribute1, :attribute10, :attribute11, :attribute12, :attribute13, :attribute14, :attribute15, :attribute16, :attribute2, :attribute3, :attribute4, :attribute5, :attribute6, :attribute7, :attribute8, :attribute9, :cl_aisle_id, :cl_barcode, :cl_bay_id, :cl_level_id, :cl_loc_id, :cl_pos_id, :cl_warehouse_id, :cl_zone_id, :client_id, :current_item, :current_quantity,  :life_time_total_picks, :lock_code, :location_priority, :maximum_quantity, :minimum_quantity, :sm_aisle_id, :sm_barcode, :sm_bay_id, :sm_level_id, :sm_loc_id, :sm_pos_id, :sm_warehouse_id, :sm_zone_id, :status
  validates :cl_barcode, :uniqueness => {:scope => :cl_warehouse_id , :allow_nil => true, :allow_blank => true,  :message => "Location Already Exists"}
end
