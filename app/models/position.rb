class Position < ActiveRecord::Base
  
  before_save   :update_positions 
  after_save :update_location_rating
  after_destroy :update_level_for_delete
  after_create  :update_level_for_add
  
  attr_accessible :attribute1, :attribute10, :attribute11, :attribute12, :attribute13, :attribute14, :attribute15, :attribute16, :attribute2, :attribute3, :attribute4, :attribute5, :attribute6, :attribute7, :attribute8, :attribute9, :cl_aisle_id, :cl_barcode, :cl_bay_id, :cl_level_id, :cl_pos_id, :cl_warehouse_id, :cl_zone_id, :client_id, :description, :level_id, :sm_aisle_id, :sm_barcode, :sm_bay_id, :sm_level_id, :sm_pos_id, :sm_warehouse_id, :sm_zone_id
  validates :cl_pos_id, :uniqueness => {:scope => :level_id , :allow_nil => true, :allow_blank => true,  :message => "Position Already Exists"}
  
 def update_positions 
   
    self.cl_barcode = cl_zone_id.to_s + "-" + cl_aisle_id.to_s + "-" + cl_bay_id.to_s + "-" + cl_level_id.to_s + "-" + cl_pos_id.to_s
 
   case self.attribute1
    when "Default"
      
        self.description = cl_zone_id.to_s + "-" + cl_aisle_id.to_s + "-" + cl_bay_id.to_s + "-" + cl_level_id.to_s + "-" + cl_pos_id.to_s

    
                                
      when "Continue"
        
        previous_pos = getprevious_position 
        
        self.description  = previous_pos.description
        self.attribute2 = previous_pos.attribute2
                                  
                               
                                
       when "Break"
        previous_pos = getprevious_position
       
        self.description  = previous_pos.description
        self.attribute2 = previous_pos.attribute2
                                                             
   end
      
 end
 
 def getprevious_position 
   
        previous_pos = Position.where("level_id = ? AND sm_pos_id = ?" , self.level_id ,( self.sm_pos_id - 1)).first
        previous_pos = Position.where("sm_warehouse_id=? AND sm_zone_id = ? AND sm_aisle_id = ? AND sm_bay_id=? AND sm_level_id=?" , self.sm_warehouse_id ,self.sm_zone_id, self.sm_aisle_id, self.sm_bay_id, (self.sm_level_id-1)).last if previous_pos.nil?
        previous_pos = Position.where("sm_warehouse_id=? AND sm_zone_id = ? AND sm_aisle_id = ? AND sm_bay_id=?" , self.sm_warehouse_id ,self.sm_zone_id, self.sm_aisle_id, (self.sm_bay_id-1)).last if previous_pos.nil?
        previous_pos = self if previous_pos.nil?
        return previous_pos
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
    selected_locations = Location.where('cl_pos_id = ? and cl_level_id = ? and cl_bay_id = ? and cl_aisle_id = ? and cl_zone_id = ? and cl_warehouse_id = ? ' , self.cl_pos_id , self.cl_level_id ,  self.cl_bay_id , self.cl_aisle_id , self.cl_zone_id , self.cl_warehouse_id)
      selected_locations.each do |selected_location|
        
         selected_location.location_priority = '00-00-00-00-00' if selected_location.location_priority.blank?
         selected_location.location_priority =  selected_location.location_priority[0,12]  + get_rating(self.attribute4).strip 
         #selected_location.location_priority = ""
         selected_location.save
             
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
