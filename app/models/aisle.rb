class Aisle < ActiveRecord::Base
  has_many :bays, :dependent => :destroy
  
   after_save :update_bays
   after_destroy :update_aisles_for_delete
   after_create :update_aisles_for_add
   
  attr_accessible :attribute1, :attribute2, :attribute3, :attribute4, :attribute5, :attribute6, :attribute7, :attribute8, :cl_aisle_id, :cl_warehouse_id, :cl_zone_id, :client_id, :description, :no_of_bays_aisle, :no_of_levels_aisle, :sm_aisle_id, :sm_warehouse_id, :sm_zone_id, :zone_id
  validates :cl_aisle_id, :uniqueness => {:scope => :zone_id , :allow_nil => true, :allow_blank => true,  :message => "Aisle Already Exists"}
  
  def update_bays
     if cl_warehouse_id_changed? or cl_zone_id_changed? or cl_aisle_id_changed?
       bays = Bay.where(:aisle_id => self.id)
       bays.each do |bay|
         bay.update_attributes({
           :cl_warehouse_id => self.cl_warehouse_id,
           :cl_zone_id => self.cl_zone_id,
           :cl_aisle_id => self.cl_aisle_id
           })
      end
    end
  end
  
  def update_aisles_for_delete
    
    zone = Zone.find(self.zone_id)
    zone.update_attributes({:no_of_aisles_zone => zone.no_of_aisles_zone - 1 })
    
  end
  
  def update_aisles_for_add
    
    zones = Zone.find(self.zone_id)
    zones.update_attributes({:no_of_aisles_zone => zones.no_of_aisles_zone + 1 })
    
  end
end
