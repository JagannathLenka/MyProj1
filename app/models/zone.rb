class Zone < ActiveRecord::Base
  has_many :aisles, :dependent => :destroy
  
  after_save :update_aisles
  after_save :update_seqno_aisle
  after_save :update_seqno_bay
  after_destroy :update_zones_for_delete
  after_create  :update_zones_for_add
  
  attr_accessible :attribute1, :attribute2, :attribute3, :attribute4, :attribute5, :attribute6, :attribute7, :attribute8, :cl_warehouse_id, :cl_zone_id, :client_id, :description, :no_of_aisles_zone, :no_of_bays_aisle, :no_of_levels_aisle, :sm_warehouse_id, :sm_zone_id, :warehouse_id
  validates :cl_zone_id, :uniqueness => {:scope => :warehouse_id , :allow_nil => true, :allow_blank => true,  :message => "Zone Already Exists"}
  
#
# Update zone client id in all aisle
#  
 def update_aisles
  if cl_warehouse_id_changed? or cl_zone_id_changed?
     aisles = Aisle.where(:zone_id => self.id)
     aisles.each do |aisle|
         aisle.update_attributes({
           :cl_warehouse_id => self.cl_warehouse_id,
           :cl_zone_id => self.cl_zone_id
           })
     end
    end
  end
  

#
#update seq no for aisle
#
def update_seqno_aisle
  if no_of_aisles_zone_changed?
      aisles = Aisle.where('sm_zone_id = ? and sm_warehouse_id = ? ' ,  self.sm_zone_id , self.sm_warehouse_id).order(:sm_aisle_id)
      aisles.each_with_index do |aisle, i|
          aisle.attribute1 = "%03d" % aisle.sm_aisle_id
      aisle.save
      end
  end
end


#  
#Update the sequence for the bay
#
def update_seqno_bay
    
  if attribute1_changed?
    case self.attribute1
      
        when 'Loop'
            loop_sequence
          
        when 'OneWay'
          oneway_sequence
          
        when 'ZigZag'
          zigzag_sequence    
     
     end 
   end    
 end 
 

#
#Provide seuqence for the loop
#
def loop_sequence
   aisles = Aisle.where('sm_zone_id = ? and sm_warehouse_id = ? ' ,  self.sm_zone_id , self.sm_warehouse_id)
   aisles.each do |aisle|
     Zone.loop_sequence_with_aisle aisle
   end
    
end

def self.loop_sequence_with_aisle aisle
    bays = Bay.where(:aisle_id => aisle.id).order(:sm_bay_id)
    bays.each_with_index do |bay, i|
      bay.attribute5 = "%03d" % bay.sm_bay_id
      bay.save
    end
  
end


#
#Provide seuqence for oneway  
#
def oneway_sequence
      aisles = Aisle.where('sm_zone_id = ? and sm_warehouse_id = ? ' ,  self.sm_zone_id , self.sm_warehouse_id)
      aisles.each do |aisle|
         Zone.oneway_sequence_with_aisle aisle 

      end   
end 


def self.oneway_sequence_with_aisle aisle
   

  if aisle.attribute3 == 'LR'
      bays = Bay.where(:aisle_id => aisle.id).order(:sm_bay_id)
      bays_count = bays.count
      bays.each_with_index do |bay, i| 

          if bay.attribute3 == 'L'
             bay.attribute5 = "%03d" % (i+1)
          end
          
          #When Row changes from L to R
          if  bay.attribute3 == 'R'                    
              bay.attribute5 = "%03d" % (bays_count)
              bays_count -= 1
          end
          bay.save 
      end          
   end  
end

#
#Zigzag logic for Front-Adjacent-Front logic
#

def  zigzag_sequence
  
     @aisle_step = 1  
     aisles = Aisle.where('sm_zone_id = ? and sm_warehouse_id = ? ' ,  self.sm_zone_id , self.sm_warehouse_id)
     aisles.each do |aisle|
          if aisle.attribute3 == 'LR'
                         
             if @aisle_step == 1
                bays = Bay.where(:aisle_id => aisle.id).order(:sm_bay_id)
                @aisle_step = 2
             else
               bays = Bay.where(:aisle_id => aisle.id).order('attribute3, sm_bay_id desc')
               @aisle_step = 1     
             end           
              
             bay_array = Array.new
             bays.each_with_index do |bay,i|
             bay_array[i] = {:id => bay.sm_bay_id.to_s,  :side => bay.attribute3, :seq => ""}
               
             end
             
            @last_index = 0
            @step = 1
            count = bays.count
            (0..count-1).each do |i|

                  if i==0
                    bay_array[i][:seq]= "%03d" % (i+1) 
                 
                        @last_index = 0
                        @step = 1
                   else
                  
                   case @step
                
                    when 1
                        front = (count -1) - @last_index 
                        bay_array[front][:seq]= "%03d" % (i+1)
                        @last_index  = front 
                        @step = 2
                
                    when 2
                        if bay_array[@last_index][:side] == "R"          
                            adjacent = @last_index - 1 
                        else
                            adjacent = @last_index + 1
                        end
                        bay_array[adjacent][:seq]= "%03d" % (i+1)    
                        @last_index = adjacent
                        @step = 1
                         
                    end
                  end  
                end
             #------------------------    
              bays.each_with_index do |bay,i|
              bay.attribute5 = bay_array[i][:seq]
              bay.save
             end
          end   
     end 
  
end

#
#update no.of zones in warehouse after deleting  
#
  def update_zones_for_delete
    warehouse = Warehouse.find(self.warehouse_id)
    warehouse.update_attributes({:no_of_zones => warehouse.no_of_zones.to_i - 1})
  end
  
   def update_zones_for_add
    warehouses = Warehouse.find(self.warehouse_id)
    warehouses.update_attributes({:no_of_zones => warehouses.no_of_zones.to_i + 1})
  end
  
end
