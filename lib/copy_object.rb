module CopyObject


def self.copyBaytoAisle bay_id 
    
    copied_from_bay = Bay.find(bay_id)
    
    bays = Bay.where(aisle_id: copied_from_bay.aisle_id)
    bays.each do |bay|
      if bay.id != bay_id
        copy_BaytoBay  copied_from_bay , bay
      end
    end
end

def self.copyLeveltoLevel level_id 
    
    copied_from_level = Level.find(level_id)
    levels = Level.where(bay_id: copied_from_level.bay_id)
   
    levels.each do |level|
      if level.id != level_id
        copy_LeveltoLevel copied_from_level , level
      end
    end
end

def self.copy_BaytoBay copied_from_bay , copied_to_bay
         
        #Update the level
        update_level copied_from_bay.id , copied_to_bay.id
        
        
        #Update the bay
      
        copied_to_bay.update_attributes({ 
                           
                           :attribute1 => copied_from_bay.attribute1,
                           :attribute2 => copied_from_bay.attribute2, 
                           :attribute4 => copied_from_bay.attribute4,
                           :attribute5 => copied_from_bay.attribute5,
                           :attribute6 => copied_from_bay.attribute6,
                           :attribute7 => copied_from_bay.attribute7,
                           :attribute8 => copied_from_bay.attribute8   
                        })                
     
end

def self.update_level copied_from_bay_id,  copied_to_bay_id  
    from_levels = Level.where(bay_id: copied_from_bay_id)
    from_levels.each do |from_level|
    to_level = Level.where("bay_id = ? AND sm_level_id = ?", copied_to_bay_id, from_level.sm_level_id).first
    
    copy_LeveltoLevel from_level , to_level
    
 end
end  
    
def self.copy_LeveltoLevel copied_from_level , copied_to_level
  
               diff_position = (copied_from_level.no_of_pos_level.to_i  - copied_to_level.no_of_pos_level.to_i)
                if copied_from_level.bay_id == copied_to_level.bay_id
                   copy_cl_level_id = copied_to_level.cl_level_id
                 else
                   copy_cl_level_id = copied_from_level.cl_level_id
                end
               copied_to_level.update_attributes({                                   
                                     
                                     :cl_level_id => copy_cl_level_id,
                                     :description => copied_from_level.description,
                                     :attribute1 => copied_from_level.attribute1,
                                     :attribute2 => copied_from_level.attribute2, 
                                     :attribute3 => copied_from_level.attribute3, 
                                     :attribute4 => copied_from_level.attribute4,
                                     :attribute5 => copied_from_level.attribute5,
                                     :attribute6 => copied_from_level.attribute6,
                                     :attribute7 => copied_from_level.attribute7,
                                     :attribute8 => copied_from_level.attribute8    
            })
            
               create_position copied_to_level, diff_position 
           
               update_position copied_from_level, copied_to_level

end

def self.create_position level , diff_posvalue
     max_pos = Position.where(:level_id => level.id).maximum("sm_pos_id").to_i
      (1..diff_posvalue).each do |p|
         pos =Position.create(:sm_pos_id => max_pos + p,
                         :sm_level_id   => level.sm_level_id,
                         :sm_bay_id     => level.sm_bay_id,
                         :sm_aisle_id   => level.sm_aisle_id,
                         :sm_zone_id    => level.sm_zone_id,
                         :sm_warehouse_id => level.sm_warehouse_id,
                         :level_id      => level.id,
                         :cl_level_id   => level.cl_level_id,
                         :cl_aisle_id   => level.cl_aisle_id,
                         :cl_zone_id    => level.cl_zone_id,
                         :cl_warehouse_id => level.cl_warehouse_id,
                         :cl_bay_id     => level.cl_bay_id
                     )
           end     

end

def self.update_position copied_from_level, copied_to_level
  
   from_positions = Position.where(:level_id => copied_from_level.id)
   from_positions.each do |from_position|
     
     to_position = Position.where("level_id = ? AND sm_pos_id = ?", copied_to_level.id , from_position.sm_pos_id).first
     to_position.update_attributes({
       
                                 :cl_pos_id => from_position.cl_pos_id,
                                 :cl_barcode => to_position.cl_zone_id.to_s + "-" + to_position.cl_aisle_id.to_s  + "-" + to_position.cl_bay_id.to_s + "-"  + to_position.cl_level_id.to_s + "-" + from_position.cl_pos_id.to_s,
                                 :description => from_position.description,
                                 :attribute1 => from_position.attribute1,
                                 :attribute2 => from_position.attribute2, 
                                 :attribute3 => from_position.attribute3,
                                 :attribute4 => from_position.attribute4,
                                 :attribute5 => from_position.attribute5,
                                 :attribute6 => from_position.attribute6,
                                 :attribute7 => from_position.attribute7,
                                 :attribute8 => from_position.attribute8    
                                
     })
   end 
  
end

end