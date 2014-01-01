class Level < ActiveRecord::Base
  has_many :positions, :dependent => :destroy
  
  after_save :update_positions
  after_save :update_seqno_pos
  after_save :update_location_rating
  after_destroy :update_bays_for_delete
  after_create  :update_bays_for_add
  
  attr_accessible :attribute1, :attribute2, :attribute3, :attribute4, :attribute5, :attribute6, :attribute7, :attribute8, :bay_id, :cl_aisle_id, :cl_bay_id, :cl_level_id, :cl_warehouse_id, :cl_zone_id, :client_id, :description, :no_of_pos_level, :sm_aisle_id, :sm_bay_id, :sm_level_id, :sm_warehouse_id, :sm_zone_id
  validates :cl_level_id, :uniqueness => {:scope => :bay_id , :allow_nil => true, :allow_blank => true,  :message => "Level Already Exists"}
  
  def update_positions
     if cl_warehouse_id_changed? or cl_zone_id_changed? or cl_aisle_id_changed? or cl_bay_id_changed? or cl_level_id_changed?
         positions = Position.where(:level_id => self.id)
         positions.each do |position|
         position.update_attributes({
               :cl_warehouse_id => self.cl_warehouse_id,
               :cl_zone_id => self.cl_zone_id,
               :cl_aisle_id => self.cl_aisle_id,
               :cl_bay_id => self.cl_bay_id,
               :cl_level_id => self.cl_level_id
               })
       end        
     end
  end
  
  
  def update_seqno_pos
   if no_of_pos_level_changed?
    positions = Position.where('sm_level_id = ? and sm_bay_id = ? and sm_aisle_id = ? and sm_zone_id = ? and sm_warehouse_id = ? ' , self.sm_level_id ,  self.sm_bay_id , self.sm_aisle_id , self.sm_zone_id , self.sm_warehouse_id).order(:sm_level_id)
    positions.each_with_index do |pos, i|
      pos.attribute3= "%03d" % pos.sm_pos_id
      pos.save
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
    selected_locations = Location.where('cl_level_id = ? and cl_bay_id = ? and cl_aisle_id = ? and cl_zone_id = ? and cl_warehouse_id = ? ' , self.cl_level_id ,  self.cl_bay_id , self.cl_aisle_id , self.cl_zone_id , self.cl_warehouse_id)
      selected_locations.each do |selected_location|
        
         selected_location.location_priority = '00-00-00-00-00' if selected_location.location_priority.blank?
         selected_location.location_priority =  selected_location.location_priority[0,9]  + get_rating(self.attribute4).strip +  selected_location.location_priority[11,3]
         #selected_location.location_priority = ""
         selected_location.save
             
        end
        
    end
  end
  
  
  def update_bays_for_delete
    bay = Bay.find(self.bay_id)
    bay.update_attributes({:no_of_level_bay => bay.no_of_level_bay.to_i - 1})
    
  end
  
 def update_bays_for_add
   bays = Bay.find(self.bay_id)
   bays.update_attributes({ :no_of_level_bay => bays.no_of_level_bay.to_i + 1})
    
  end 
end
