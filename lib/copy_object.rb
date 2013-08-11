module CopyObject


def self.copyBaytoAisle bay_id 
    
    copied_from_bay = Bay.find(bay_id)
    
    bays = Bay.where(aisle_id: copied_from_bay.aisle_id)
    bays.each do |bay|
      if bay.id != bay_id
        
        #Update the level
        update_level copied_from_bay.id, bay.id  
        
        #Update the bay
        bay.update_attributes({ 
                           :no_of_level_bay  => copied_from_bay.no_of_level_bay,
                           :attribute1 => copied_from_bay.attribute1,
                           :attribute2 => copied_from_bay.attribute2, 
                           :attribute4 => copied_from_bay.attribute4,
                           :attribute5 => copied_from_bay.attribute5,
                           :attribute6 => copied_from_bay.attribute6,
                           :attribute7 => copied_from_bay.attribute7,
                           :attribute8 => copied_from_bay.attribute8   
                        })                
      end
    end
     
end

def self.update_level copied_from_bay_id,  copied_to_bay_id  
    from_levels = Level.where(bay_id: copied_from_bay_id)
    
    from_levels.each do |from_level|
      to_level = Level.where("bay_id = ? AND sm_level_id = ?", copied_to_bay_id, from_level.sm_level_id).first
               diff_position = (from_level.no_of_pos_level.nil? ? 0 : from_level.no_of_pos_level) -
                               (to_level.no_of_pos_level.nil?   ? 0 : to_level.no_of_pos_level)
                  
                to_level.update_attributes({                                   
                                     :cl_level_id => from_level.cl_level_id,
                                     :no_of_pos_level => 0,
                                     :attribute1 => from_level.attribute1,
                                     :attribute2 => from_level.attribute2, 
                                     :attribute3 => from_level.attribute3,
                                     :attribute4 => from_level.attribute4,
                                     :attribute5 => from_level.attribute5,
                                     :attribute6 => from_level.attribute6,
                                     :attribute7 => from_level.attribute7,
                                     :attribute8 => from_level.attribute8    
                                         
            })
               create_position to_level, diff_position 
               to_level.update_attributes({                                   
                                     :no_of_pos_level => from_level.no_of_pos_level
                                   })
                                   
    end
  
end

def self.create_position level , diff_posvalue
     max_pos = Position.where(:level_id => level.id).maximum("sm_pos_id").to_i
      (1..diff_posvalue).each do |p|
         pos =Position.create(:sm_pos_id => max_pos + p,
                         :sm_level_id => level.sm_level_id,
                         :sm_bay_id => level.sm_bay_id,
                         :sm_aisle_id => level.sm_aisle_id,
                         :sm_zone_id => level.sm_zone_id,
                         :sm_warehouse_id => level.sm_warehouse_id,
                         :sm_barcode => "",
                         :level_id => level.id,
                         :cl_barcode => "",
                         :cl_pos_id => "",
                         :cl_level_id => level.cl_level_id,
                         :cl_bay_id => level.cl_bay_id,
                         :cl_aisle_id => level.cl_aisle_id,
                         :cl_zone_id => level.cl_zone_id,
                         :cl_warehouse_id => level.cl_warehouse_id
                           
                     )
           end     

end


end