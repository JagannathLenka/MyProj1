class Bay < ActiveRecord::Base
  has_many :levels, :dependent => :destroy
  attr_accessible :aisle_id, :attribute1, :attribute2, :attribute3, :attribute4, :attribute5, :attribute6, :attribute7, :attribute8, :cl_aisle_id, :cl_bay_id, :cl_warehouse_id, :cl_zone_id, :client_id, :description, :no_of_level_bay, :sm_aisle_id, :sm_bay_id, :sm_warehouse_id, :sm_zone_id
end
