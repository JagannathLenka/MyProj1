module CopyObject
#-------------------------------------------Copy Aisle-----------------------------------------------#  
# Copy Bay,Level,Postion to one aisle from other Aisle to zone  
def self.copyAisletoZone aisle_id
  
  copied_from_aisle = Aisle.find(aisle_id)
  aisles = Aisle.where(zone_id: copied_from_aisle.zone_id)
  aisles.each do |aisle|
    if aisle.id != aisle_id
      copy_AisletoAisle copied_from_aisle , aisle
    end
  end
end

# Copy Bay,Level,Postion to one aisle from other aisle 
def self.copy_AisletoAisle copied_from_aisle , copied_to_aisle
  
 
  #Create the bay(if not yet created) in the new aisle
  diff_bay = (copied_from_aisle.no_of_bays_aisle.to_i - copied_to_aisle.no_of_bays_aisle.to_i)
  create_bay copied_to_aisle , diff_bay

  #Create and Update the child entities (level, position) in the other aisle similar to the "Copied from aisle"  
  update_aisle copied_from_aisle.id,  copied_to_aisle.id  
  
  #Update the aisle with the rest of the parameters as the copied from aisle 
  copy_cl_aisle_id = copied_from_aisle.zone_id == copied_to_aisle.zone_id ? 
                     copied_to_aisle.cl_aisle_id: copied_from_aisle.cl_aisle_id
  copied_to_aisle.update_attributes({
                                   :cl_aisle_id => copy_cl_aisle_id,
                                   :no_of_levels_aisle => copied_from_aisle.no_of_levels_aisle,
                                   :attribute1 => copied_from_aisle.attribute1,
                                   :attribute2 => copied_from_aisle.attribute2, 
                                   :attribute3 => copied_from_aisle.attribute3,
                                   :attribute4 => copied_from_aisle.attribute4,
                                   :attribute5 => copied_from_aisle.attribute5,
                                   :attribute6 => copied_from_aisle.attribute6,
                                   :attribute7 => copied_from_aisle.attribute7,
                                   :attribute8 => copied_from_aisle.attribute8 
    })
    @error =  copied_to_aisle.errors.values[0][0] if copied_to_aisle.errors.count > 0       
 end

#Create the bay(if not yet created) in the new aisle
 def self.create_bay aisle , diff_bayval
    max_bays  = Bay.where(:aisle_id => aisle.id).maximum("sm_bay_id").to_i
    (1.. diff_bayval).each do |b|
             bay = Bay.create(:sm_bay_id            => max_bays + b,
                             :sm_aisle_id         => aisle.sm_aisle_id,
                             :sm_zone_id          => aisle.sm_zone_id,
                             :sm_warehouse_id     => aisle.sm_warehouse_id,
                             :aisle_id            => aisle.id,
                             :cl_aisle_id         => aisle.cl_aisle_id,
                             :cl_zone_id          => aisle.cl_zone_id,
                             :cl_warehouse_id     => aisle.cl_warehouse_id,
                             :no_of_level_bay     => 0,
                          )
             @error =  bay.errors.values[0][0] if bay.errors.count > 0         
       end
 end

#Create and Update the child entities (level, position) in the other aisle similar to the "Copied from aisle"  
def self.update_aisle copied_from_aisle_id,  copied_to_aisle_id  
    from_bays = Bay.where(aisle_id: copied_from_aisle_id)
    from_bays.each do |from_bay|
    to_bay = Bay.where("aisle_id = ? AND sm_bay_id = ?", copied_to_aisle_id, from_bay.sm_bay_id).first
    
    copy_BaytoBay from_bay , to_bay
    
 end
end 

#-------------------------------------------Copy Bay-----------------------------------------------#  
# Copy Level and Postion to bay from other bay of aisle  
def self.copyBaytoAisle bay_id 
    
    copied_from_bay = Bay.find(bay_id)
    
    bays = Bay.where(aisle_id: copied_from_bay.aisle_id)
    bays.each do |bay|
      if bay.id != bay_id
        copy_BaytoBay  copied_from_bay , bay
      end
    end
end

#Copy level, position from one bay to any bay 
def self.copy_BaytoBay copied_from_bay , copied_to_bay
         
        # Copy Level,Postion to one bay from other bay 
        diff_level = (copied_from_bay.no_of_level_bay.to_i - copied_to_bay.no_of_level_bay.to_i)
        create_level copied_to_bay , diff_level
        
        #Create and Update the child entities (position) in the other bay similar to the "Copied from bay"  
        update_level copied_from_bay.id , copied_to_bay.id
        
        
        #Update the bay      
        copy_cl_bay_id = copied_from_bay.aisle_id == copied_to_bay.aisle_id ? 
                     copied_to_bay.cl_bay_id: copied_from_bay.cl_bay_id  
        copy_attribute3 = copied_from_bay.aisle_id == copied_to_bay.aisle_id ? 
                     copied_to_bay.attribute3: copied_from_bay.attribute3  
                           
        copied_to_bay.update_attributes({ 
                           :cl_bay_id  => copy_cl_bay_id,
                           :attribute1 => copied_from_bay.attribute1,
                           :attribute2 => copied_from_bay.attribute2, 
                           :attribute3 => copy_attribute3,
                           :attribute4 => copied_from_bay.attribute4,
                           :attribute5 => copied_from_bay.attribute5,
                           :attribute6 => copied_from_bay.attribute6,
                           :attribute7 => copied_from_bay.attribute7,
                           :attribute8 => copied_from_bay.attribute8   
                        })                
     @error =  copied_to_bay.errors.values[0][0] if copied_to_bay.errors.count > 0         
end

# Create level for a bay for given number of level  
 def self.create_level bay , diff_level
    max_level  = Level.where(:bay_id => bay.id).maximum("sm_level_id").to_i
    (1.. diff_level).each do |lev|
                  levels = Level.create(
                             :sm_level_id         => max_level + lev,
                             :sm_bay_id           => bay.sm_bay_id,
                             :sm_aisle_id         => bay.sm_aisle_id,
                             :sm_zone_id          => bay.sm_zone_id,
                             :sm_warehouse_id     => bay.sm_warehouse_id,
                             :bay_id              => bay.id,
                             :cl_level_id         => "",
                             :cl_bay_id           => bay.cl_bay_id,
                             :cl_aisle_id         => bay.cl_aisle_id,
                             :cl_zone_id          => bay.cl_zone_id,
                             :cl_warehouse_id     => bay.cl_warehouse_id
                          )
           @error =  levels.errors.values[0][0] if levels.errors.count > 0   
       end
 end

#-------------------------------------------Copy Level-----------------------------------------------#  
#Copy from one level to other level in a bay
def self.copyLeveltoBay level_id 
    
    copied_from_level = Level.find(level_id)
    levels = Level.where(bay_id: copied_from_level.bay_id)
   
    levels.each do |level|
      if level.id != level_id
        copy_LeveltoLevel copied_from_level , level
      end
    end
end


# Update the level information from one level to other in a given bay
def self.update_level copied_from_bay_id,  copied_to_bay_id  
    from_levels = Level.where(bay_id: copied_from_bay_id)
    from_levels.each do |from_level|
    to_level = Level.where("bay_id = ? AND sm_level_id = ?", copied_to_bay_id, from_level.sm_level_id).first
    
    copy_LeveltoLevel from_level , to_level
    
 end
end  

# Copy the level information from one level to other level    
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
               @error =  copied_to_level.errors.values[0][0] if copied_to_level.errors.count > 0    
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
           @error =  pos.errors.values[0][0] if pos.errors.count > 0 
           end     

end

#Update the positions details from one level to other level
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
    @error =  to_position.errors.values[0][0] if to_position.errors.count > 0 
   end 
   
  
end

end