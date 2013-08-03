class Warehouse < ActiveRecord::Base
  has_many :zones, :dependent => :destroy
  attr_accessible :attribute1, :attribute2, :attribute3, :attribute4, :attribute5, :attribute6, :attribute7, :attribute8, :cl_warehouse_id, :client_id, :description, :no_of_zones, :sm_warehouse_id
end
