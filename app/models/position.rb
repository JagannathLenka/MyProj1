class Position < ActiveRecord::Base
  
  before_save   :update_positions
  after_save :update_location_rating
  after_destroy :update_level_for_delete
  after_create  :update_level_for_add
  
  attr_accessible :attribute1, :attribute10, :attribute11, :attribute12, :attribute13, :attribute14, :attribute15, :attribute16, :attribute2, :attribute3, :attribute4, :attribute5, :attribute6, :attribute7, :attribute8, :attribute9, :cl_aisle_id, :cl_barcode, :cl_bay_id, :cl_level_id, :cl_pos_id, :cl_warehouse_id, :cl_zone_id, :client_id, :description, :level_id, :sm_aisle_id, :sm_barcode, :sm_bay_id, :sm_level_id, :sm_pos_id, :sm_warehouse_id, :sm_zone_id
  validates :cl_pos_id, :uniqueness => {:scope => :level_id , :allow_nil => true, :allow_blank => true,  :message => "Position Already Exists"}
  
  def update_positions
   case self.attribute1
    when "Default"
    self.cl_barcode = cl_zone_id.to_s + "-" + cl_aisle_id.to_s + "-" + cl_bay_id.to_s + "-" + cl_level_id.to_s + "-" + cl_pos_id.to_s
    end
  end
  
  def get_rating (priority)
    
     location_rating = 0
      
      case priority 
          when "Default"
            location_rating = 0
          when "High"
             location_rating = 9
          when "Medium"
             location_rating = 5
          when "Low"
             location_rating = 2
          else
             location_rating = 0
      end
     return location_rating
     
  end
  
  def update_location_rating
  
    if attribute4_changed?
    selected_locations = Location.where('cl_pos_id = ? and cl_level_id = ? and cl_bay_id = ? and cl_aisle_id = ? and cl_zone_id = ? and cl_warehouse_id = ? ' , self.cl_pos_id , self.cl_level_id ,  self.cl_bay_id , self.cl_aisle_id , self.cl_zone_id , self.cl_warehouse_id)
      selected_locations.each do |selected_location|
        
          selected_location.update_attributes({
          :location_priority => (selected_location.location_priority.to_i) - (get_rating(self.attribute4_was) * 10) + (get_rating(self.attribute4) * 10) 
          
           })
          end
        
    end
  end
  
  
  def update_level_for_delete
    level = Level.find(self.level_id)
    level.update_attributes({:no_of_pos_level => level.no_of_pos_level.to_i - 1})
  end
  
  def update_level_for_add
     levels = Level.find(self.level_id)
     levels.update_attributes({:no_of_pos_level => levels.no_of_pos_level.to_i + 1}) 
  end
end
