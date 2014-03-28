class Bay < ActiveRecord::Base
  has_many :levels, :dependent => :destroy
  
  after_save :update_levels 
  after_save :update_seqno_level
  after_save :update_location_rating
  after_save :update_seqno_loc
  
  attr_accessible :aisle_id, :attribute1, :attribute2, :attribute3, :attribute4, :attribute5, :attribute6, :attribute7, :attribute8, :cl_aisle_id, :cl_bay_id, :cl_warehouse_id, :cl_zone_id, :client_id, :description, :no_of_level_bay, :sm_aisle_id, :sm_bay_id, :sm_warehouse_id, :sm_zone_id
  validates :cl_bay_id, :uniqueness => {:scope => :aisle_id , :allow_nil => true, :allow_blank => true,  :message => "Bay Already Exists"}
  
  #While changing the CL id of Warehouse, zone or aisle
  def update_levels
    if cl_warehouse_id_changed? or cl_zone_id_changed? or cl_aisle_id_changed? or cl_bay_id_changed?
     levels = Level.where(:bay_id => self.id)
     levels.each do |level|
     level.update_attributes({
           :cl_warehouse_id => self.cl_warehouse_id,
           :cl_zone_id => self.cl_zone_id,
           :cl_aisle_id => self.cl_aisle_id,
           :cl_bay_id => self.cl_bay_id
           })
     end
     end
  end
  
  def update_seqno_level
    if no_of_level_bay_changed?
      levels = Level.where('sm_bay_id = ? and sm_aisle_id = ? and sm_zone_id = ? and sm_warehouse_id = ? ' ,  self.sm_bay_id , self.sm_aisle_id , self.sm_zone_id , self.sm_warehouse_id).order(:sm_level_id)
      levels.each_with_index do |level, i|
         level.attribute1 = "%03d" % level.sm_level_id
      level.save
     end
    end  
  end
  
  def update_seqno_loc
    if no_of_level_bay_changed?
     selected_locations = Location.where('cl_bay_id = ? and cl_aisle_id = ? and cl_zone_id = ? and cl_warehouse_id = ? ' , self.cl_bay_id , self.cl_aisle_id , self.cl_zone_id , self.cl_warehouse_id)
     selected_locations.each do |selected_location|
        
        selected_location.attribute2 = '000-000-000-000-000' if (selected_location.attribute2.blank? or selected_location.attribute2.nil?)
        selected_location.attribute2 =  selected_location.attribute2[0,8]  + self.attribute5 +  selected_location.attribute2[11,8]
        selected_location.save
      
      end
         
     end  
   
  end
  
  #
  # Get the priority for the rating
  #
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
     
      selected_locations = Location.where('cl_bay_id = ? and cl_aisle_id = ? and cl_zone_id = ? and cl_warehouse_id = ? ' , self.cl_bay_id , self.cl_aisle_id , self.cl_zone_id , self.cl_warehouse_id)
      selected_locations.each do |selected_location|
        
         selected_location.location_priority = '00-00-00-00-00' if selected_location.location_priority.blank?
         selected_location.location_priority =  selected_location.location_priority[0,6]  + get_rating(self.attribute4).strip +  selected_location.location_priority[8,6]
         #selected_location.location_priority = ""
         selected_location.save
             
        end
          
        
    end
  end


 #
 # Add Levels for each bays
 #
 def self.add_levels_to_bay bay, no_of_levels
   
   max_levels  = Level.where(:bay_id => bay.id).maximum("sm_level_id").to_i

   #levelvalue = params[:no_of_levels_aisle].to_i
   levelvalue = no_of_levels
   existingLevel = bay.no_of_level_bay.nil? ? 0 : bay.no_of_level_bay
   

      diff_levelvalue = levelvalue - existingLevel
      (1..diff_levelvalue).each do |lev|
                  levels = Level.new(
                             :sm_level_id     => max_levels + lev,
                             :sm_bay_id           => bay.sm_bay_id,
                             :sm_aisle_id         => bay.sm_aisle_id,
                             :sm_zone_id          => bay.sm_zone_id,
                             :sm_warehouse_id     => bay.sm_warehouse_id,
                             :bay_id              => bay.id,
                             :cl_level_id         => "",
                             :cl_bay_id           => bay.cl_bay_id,
                             :cl_aisle_id         => bay.cl_aisle_id,
                             :cl_zone_id          => bay.cl_zone_id,
                             :cl_warehouse_id     => bay.cl_warehouse_id,
                             :no_of_pos_level     => ""
                          )
                 levels.save
      end
 end
 
 # 
 #Remove level from bay
 #
 def self.remove_levels_from_bay bay, no_of_levels
   
    
     #levelvalue = params[:no_of_levels_aisle].to_i
     levelvalue = no_of_levels
     existingLevel = bay.no_of_level_bay.nil? ? 0 : bay.no_of_level_bay


     diff_bayval = existingLevel - levelvalue 

         (1.. diff_bayval).each do |b|
           Level.where(:bay_id => bay.id).last.destroy
       end
       
 end
 
 
 def self.refresh_bay bay_id
   location_found = true
   bay = Bay.find(bay_id)
   positions = Position.where("sm_warehouse_id = ? AND sm_zone_id = ? AND sm_aisle_id = ? AND sm_bay_id = ?" ,bay.sm_warehouse_id , bay.sm_zone_id , bay.sm_aisle_id , bay.sm_bay_id).order(:sm_level_id , :sm_pos_id)
   positions.each do |position| 
   location = Location.where("cl_warehouse_id = ? AND cl_barcode = ?", position.cl_warehouse_id , position.cl_barcode).first 
     if location.nil?
       position.attribute1 = "Continue" 
       position.save
       location_found = false
     else 

       position.attribute1 = (location_found ? "Default" : "Break")
       position.save
       location_found = true
     end
     
    end
 end
 

 # 
 #
 # 

  

end


