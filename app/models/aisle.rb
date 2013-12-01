class Aisle < ActiveRecord::Base
  has_many :bays, :dependent => :destroy
  
   after_save :update_bays
   after_save :update_location_rating
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
 
   def get_rating (priority)
    
     location_rating = '00'
      
      case priority 
          when "Default"
            location_rating = '00'
          when "High"
             location_rating = '09'
          when "Medium"
             location_rating = '05'
          when "Low"
             location_rating = '02'
          else
             location_rating = '00'
      end
     return location_rating
     
  end
  
  def update_location_rating
  
    if attribute4_changed?
     
      selected_locations = Location.where('cl_aisle_id = ? and cl_zone_id = ? and cl_warehouse_id = ? ' , self.cl_aisle_id , self.cl_zone_id , self.cl_warehouse_id)
      selected_locations.each do |selected_location|
        
         selected_location.location_priority = '00-00-00-00-00' if selected_location.location_priority.blank?
         selected_location.location_priority =  selected_location.location_priority[0,3]  + get_rating(self.attribute4).strip +  selected_location.location_priority[5,9]
         #selected_location.location_priority = ""
         selected_location.save
             
        end
          
        
    end
  end
 
  def update_aisles_for_delete
    
    zone = Zone.find(self.zone_id)
    zone.update_attributes({:no_of_aisles_zone => zone.no_of_aisles_zone.to_i - 1 })
    
  end
  
  def update_aisles_for_add
    
    zones = Zone.find(self.zone_id)
    zones.update_attributes({:no_of_aisles_zone => zones.no_of_aisles_zone.to_i + 1 })
    
  end
end
