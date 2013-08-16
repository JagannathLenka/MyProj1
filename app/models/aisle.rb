class Aisle < ActiveRecord::Base
  has_many :bays, :dependent => :destroy
   after_save :update_bays
  attr_accessible :attribute1, :attribute2, :attribute3, :attribute4, :attribute5, :attribute6, :attribute7, :attribute8, :cl_aisle_id, :cl_warehouse_id, :cl_zone_id, :client_id, :description, :no_of_bays_aisle, :no_of_levels_aisle, :sm_aisle_id, :sm_warehouse_id, :sm_zone_id, :zone_id
  
  def update_bays
     if cl_warehouse_id_changed? or cl_zone_id_changed? or cl_aisle_id_changed?
       bays.each do |bay|
         bay.update_attributes({
           :cl_warehouse_id => self.cl_warehouse_id,
           :cl_zone_id => self.cl_zone_id,
           :cl_aisle_id => self.cl_aisle_id
           })
      end
    end
  end
end
