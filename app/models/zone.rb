class Zone < ActiveRecord::Base
  has_many :aisles, :dependent => :destroy
  after_save :update_aisles
 attr_accessible :attribute1, :attribute2, :attribute3, :attribute4, :attribute5, :attribute6, :attribute7, :attribute8, :cl_warehouse_id, :cl_zone_id, :client_id, :description, :no_of_aisles_zone, :no_of_bays_aisle, :no_of_levels_aisle, :sm_warehouse_id, :sm_zone_id, :warehouse_id
def update_aisles
  if cl_warehouse_id_changed? or cl_zone_id_changed?
     aisles = Aisle.where(:zone_id => self.id)
     aisles.each do |aisle|
         aisle.update_attributes({
           :cl_warehouse_id => self.cl_warehouse_id,
           :cl_zone_id => self.cl_zone_id
           })
     end
    end
  end
end
