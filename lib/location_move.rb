class LocationMovement
  
  #Exchnge of location in a particular bay
  
  def exchange_location(dragpos_id , droppos_id)
        dragpos=Position.find_by_id(dragpos_id)
        from_location=Location.find_or_initialize_by_cl_barcode_and_cl_warehouse_id(dragpos.cl_barcode, dragpos.cl_warehouse_id)
        droppos=Position.find_by_id(droppos_id)
        to_location=Location.find_or_initialize_by_cl_barcode_and_cl_warehouse_id(droppos.cl_barcode , droppos.cl_warehouse_id)
        if valid_movement? from_location , to_location , dragpos , droppos
          
        
        from = Hash.new
        
        from[:cl_warehouse_id]  = dragpos.cl_warehouse_id
        from[:current_item]     = from_location.nil? ? '' : from_location.current_item    
        from[:current_quantity] = from_location.nil? ? 0 : from_location.current_quantity 
        from[:maximum_quantity] = from_location.nil? ? 0 : from_location.maximum_quantity
        from[:minimum_quantity] = from_location.nil? ? 0 : from_location.minimum_quantity
        
        
      
        to = Hash.new
        to[:cl_warehouse_id]  = droppos.cl_warehouse_id
        to[:current_item]     = to_location.nil? ? '' : to_location.current_item    
        to[:current_quantity] = to_location.nil? ? 0 : to_location.current_quantity 
        to[:maximum_quantity] = to_location.nil? ? 0 : to_location.maximum_quantity
        to[:minimum_quantity] = to_location.nil? ? 0 : to_location.minimum_quantity

        
        to_location.cl_warehouse_id   = from[:cl_warehouse_id]
        to_location.current_item      = from[:current_item] 
        to_location.current_quantity  = from[:current_quantity]
        to_location.maximum_quantity  = from[:maximum_quantity]
        to_location.minimum_quantity  = from[:minimum_quantity]
        to_location.save
      
        
        from_location.cl_warehouse_id   = to[:cl_warehouse_id]
        from_location.current_item      = to[:current_item]     
        from_location.current_quantity  = to[:current_quantity]
        from_location.maximum_quantity  = to[:maximum_quantity] 
        from_location.minimum_quantity  = to[:minimum_quantity] 
        from_location.save
        
        return  true
        
   else
         return  false 
         
    end  
  
  end
  
 #Exchange of location in between two bays
 
 def exchange_bay(from_bay_id , to_bay_id)
     from_level = Level.where(:bay_id => from_bay_id)
     to_bay = Bay.find(to_bay_id)
     from_level.each do |level|
       from_position = Position.where(:level_id => level.id)
       from_position.each do |position|
                      to_position = Position.where("sm_warehouse_id = ?  AND sm_zone_id = ? AND sm_aisle_id = ? AND sm_bay_id = ? AND sm_level_id = ?     AND sm_pos_id = ? " ,                                        
                                                    to_bay.sm_warehouse_id,   to_bay.sm_zone_id, to_bay.sm_aisle_id, to_bay.sm_bay_id , level.sm_level_id , position.sm_pos_id).first
            exchange_location(position.id , to_position.id)                   
       end
     end
 end

def valid_movement? from_location , to_location ,from_position , to_position
   
   preference = 0
   preference += priority_location_validation from_position , to_position
   preference += lock_code_validation to_location
   preference += location_type_mismatch from_location , to_location
   preference += same_level_movement from_position , to_position
   
  return preference > 0 ? true : false
  
end

def priority_location_validation from_position , to_position
 
   from_level = Level.find(from_position.level_id)
   to_level = Level.find(to_position.level_id)
  if from_level.attribute4 == 'Yes' && to_level.attribute4 == 'No'
     return -1
  else
     return 1
  end
end

def lock_code_validation to_location
  
  return to_location.lock_code.blank? ? 1 : -1 
end

def location_type_mismatch from_location , to_location
  
  return from_location.attribute1 == to_location.attribute1 ? 1 : -1
  
end

def same_level_movement from_position , to_position
    
    if from_position.sm_aisle_id != to_position.sm_aisle_id or 
       (from_position.sm_aisle_id == to_position.sm_aisle_id and from_position.sm_aisle_id != to_position.sm_aisle_id)
       return 1      
    end
    
   return from_position.level_id == to_position.level_id ? 1 : -1
end

 
end