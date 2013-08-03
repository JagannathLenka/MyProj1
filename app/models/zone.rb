class Zone < ActiveRecord::Base
  has_many :aisles, :dependent => :destroy
  attr_accessible :attribute1, :attribute2, :attribute3, :attribute4, :attribute5, :attribute6, :attribute7, :attribute8, :cl_warehouse_id, :cl_zone_id, :client_id, :description, :no_of_aisles_zone, :no_of_bays_aisle, :no_of_levels_aisle, :sm_warehouse_id, :sm_zone_id, :warehouse_id
end
