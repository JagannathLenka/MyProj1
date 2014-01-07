class Aisle < ActiveRecord::Base
  has_many :bays, :dependent => :destroy
   after_save     :update_bays_of_aisle         #Update bays of aisles
   after_save     :update_bays_cl_id            #Update the Client id for Bays
   after_save     :update_bays_row              #Update the rows of Bays, L or R
   after_save     :update_levels_of_bays        #Update levels of the bays in aisle
   after_save     :update_location_rating       #Update priority of the location based on priority of Bay
   after_save     :update_seqno_bay             #Update sequence number of new bays based on the zone sequence type e.g. Loop, Sequence, Zigzag
   after_destroy  :update_aisles_for_delete     #Update the zones for aisle delete
   after_create   :update_aisles_for_add        #Update the zones for additino of new aisle
   
  attr_accessible :attribute1, :attribute2, :attribute3, :attribute4, :attribute5, :attribute6, :attribute7, :attribute8, :cl_aisle_id, :cl_warehouse_id, :cl_zone_id, :client_id, :description, :no_of_bays_aisle, :no_of_levels_aisle, :sm_aisle_id, :sm_warehouse_id, :sm_zone_id, :zone_id
  validates :cl_aisle_id, :uniqueness => {:scope => :zone_id , :allow_nil => true, :allow_blank => true,  :message => "Aisle Already Exists"}
 #
 #
 #
 
  def update_bays_of_aisle

    
    if no_of_bays_aisle_changed?
        current_bays_in_this_aisle =  Bay.where(:aisle_id => self.id).count
        case 
        
        #add in the number of bays
        when self.no_of_bays_aisle >  current_bays_in_this_aisle 
             Aisle.add_bays_to_aisle self , (self.no_of_bays_aisle - current_bays_in_this_aisle)
             
             
        #delete in the number of bays
        when self.no_of_bays_aisle >  current_bays_in_this_aisle
             Aisle.remove_bays_from_aisle self , (self.no_of_bays_aisle - current_bays_in_this_aisle)
             
       end   
   end       
 end

 #
 #Add bays to aisle
 #
 def self.add_bays_to_aisle aisles , no_of_bays_to_add
   
     max_bays  = Bay.where(:aisle_id => aisles.id).maximum("sm_bay_id").to_i

     diff_bayval = no_of_bays_to_add
     
         (1.. diff_bayval).each do |b|
             bays = Bay.new(:sm_bay_id            => max_bays + b,
                             :sm_aisle_id         => aisles.sm_aisle_id,
                             :sm_zone_id          => aisles.sm_zone_id,
                             :sm_warehouse_id     => aisles.sm_warehouse_id,
                             :aisle_id            => aisles.id,
                             :cl_bay_id           => "",
                             :cl_aisle_id         => aisles.cl_aisle_id,
                             :cl_zone_id          => aisles.cl_zone_id,
                             :cl_warehouse_id     => aisles.cl_warehouse_id,
                             :no_of_level_bay     => 0,
                          )
             bays.save
       end
       
 end

 #
 #Remove bays from aisles
 # 
 def self.remove_bays_from_aisle aisles , no_of_bays_to_remove
   
     diff_bayval = no_of_bays_to_remove

         (1.. diff_bayval).each do |b|
           Bay.where(:aisle_id => aisles.id).last.destroy
       end
    
 end

 
 #
 #
 # 
  def update_bays_cl_id
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
 
 #
 #
 # 
 def update_bays_row
       #When there is no change in aisle value but just change in other parameters
       
        if no_of_bays_aisle_changed? or attribute3_changed?  
             bay_set = Bay.where(:aisle_id => self.id).order('sm_bay_id')
             counter = 0
             bay_set.each do |bays| 
                 counter = counter + 1
                 
                 #Change in Sides of aisles
                 if self.attribute3 == "LR"
                   side_of_aisle = counter <= self.no_of_bays_aisle/2? "L" : "R" 
                 else
                   side_of_aisle = self.attribute3
                 end    
                     
                 bays.update_attributes({ 
                                      :attribute3          => side_of_aisle,
                                      })
             end
         end    
 end

 #
 #Update the levels of bays
 #
 def update_levels_of_bays 
       if no_of_levels_aisle_changed?
       #When there is no change in aisle value but just change in other parameters
             bays = Bay.where(:aisle_id => self.id)
             bays.each do |bay| 
    
                 case
                   
                 #if there is a add in number of level of bay   
                 when  self.no_of_levels_aisle > (bay.no_of_level_bay.nil? ? 0 : bay.no_of_level_bay)
                   Bay.add_levels_to_bay bay , self.no_of_levels_aisle
                   
                 #if there is a delete in number of level of bay   
                 when  self.no_of_levels_aisle < (bay.no_of_level_bay.nil? ? 0 : bay.no_of_level_bay)
                   Bay.remove_levels_from_bay bay , self.no_of_levels_aisle
                 end  
                 
             end
        end    
 end
 

 #
 #
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
  
 #
 #
 # 
  def update_seqno_bay
    
    if no_of_bays_aisle_changed? or attribute3_changed?
      zone = Zone.find(self.zone_id)
           
      case 
      
      when zone.attribute1 == 'Loop' || self.attribute3 != "LR"
            Zone.loop_sequence_with_aisle self
            
          
        when zone.attribute1 == 'OneWay'
           Zone.oneway_sequence_with_aisle self
          
        when zone.attribute1 == 'ZigZag'
          Zone.zigzag_sequence_with_aisle self  
     
     end 
     
    end
    
  end
 
  
 #
 #
 # 
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
 
 #
 #
 #  
  def update_aisles_for_delete
    
    zone = Zone.find(self.zone_id)
    zone.update_attributes({:no_of_aisles_zone => zone.no_of_aisles_zone.to_i - 1 })
    
  end
  
 #
 #
 # 
  def update_aisles_for_add
    
    zones = Zone.find(self.zone_id)
    zones.update_attributes({:no_of_aisles_zone => zones.no_of_aisles_zone.to_i + 1 })
    
  end
end
