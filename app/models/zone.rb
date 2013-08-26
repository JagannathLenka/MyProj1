class Zone < ActiveRecord::Base
  has_many :aisles, :dependent => :destroy
  
  after_save :update_aisles
  after_destroy :update_zones_for_delete
  after_create  :update_zones_for_add
  
  attr_accessible :attribute1, :attribute2, :attribute3, :attribute4, :attribute5, :attribute6, :attribute7, :attribute8, :cl_warehouse_id, :cl_zone_id, :client_id, :description, :no_of_aisles_zone, :no_of_bays_aisle, :no_of_levels_aisle, :sm_warehouse_id, :sm_zone_id, :warehouse_id
  validates :cl_zone_id, :uniqueness => {:scope => :warehouse_id , :allow_nil => true, :allow_blank => true,  :message => "Zone Already Exists"}
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
  #update no.of zones in warehouse after deleting
  
  def update_zones_for_delete
    warehouse = Warehouse.find(self.warehouse_id)
    warehouse.update_attributes({:no_of_zones => warehouse.no_of_zones.to_i - 1})
  end
  
   def update_zones_for_add
    warehouses = Warehouse.find(self.warehouse_id)
    warehouses.update_attributes({:no_of_zones => warehouses.no_of_zones.to_i + 1})
  end
end
