require 'csv'
class Location < ActiveRecord::Base
  attr_accessible :attribute1, :attribute10, :attribute11, :attribute12, :attribute13, :attribute14, :attribute15, :attribute16, :attribute2, :attribute3, :attribute4, :attribute5, :attribute6, :attribute7, :attribute8, :attribute9, :cl_aisle_id, :cl_barcode, :cl_bay_id, :cl_level_id, :cl_loc_id, :cl_pos_id, :cl_warehouse_id, :cl_zone_id, :client_id, :current_item, :current_quantity,  :life_time_total_picks, :lock_code, :location_priority, :maximum_quantity, :minimum_quantity, :sm_aisle_id, :sm_barcode, :sm_bay_id, :sm_level_id, :sm_loc_id, :sm_pos_id, :sm_warehouse_id, :sm_zone_id, :status
  validates :cl_barcode, :uniqueness => {:scope => :cl_warehouse_id , :allow_nil => true, :allow_blank => true,  :message => "Location Already Exists"}

def self.upload_file file , filename
  
   CSV.parse(file) do |row|
      Location.validate_process row, filename
      logger.debug filename
   end
  
end

#Validate the row and process
def self.validate_process row_array, filename
  logger.debug filename
  error = Location.is_row_valid row_array
   if error.blank?

      existloc = Location.where(" client_id = ? and cl_barcode = ? and  cl_warehouse_id = ?" , row_array[0], row_array[2], row_array[1]).first
      if existloc.nil?
          loc = Location.new(  
                           :client_id => (row_array[0].to_s.encode! 'utf-8'),                            
                           :cl_warehouse_id   => (row_array[1].to_s.encode! 'utf-8'),
                           :cl_barcode  =>(row_array[2].to_s.encode! 'utf-8'),
                           :current_item => (row_array[3].to_s.encode! 'utf-8'),
                           :current_quantity => (row_array[4].to_s.encode! 'utf-8'),
                           :life_time_total_picks  => (row_array[5].to_s.encode! 'utf-8'),
                           :lock_code => (row_array[6].to_s.encode! 'utf-8'),
                           :maximum_quantity =>(row_array[7].to_s.encode! 'utf-8'),
                           :minimum_quantity => (row_array[8].to_s.encode! 'utf-8'),
                           :status => (row_array[9].to_s.encode! 'utf-8')
                           )
             loc.save
             Location.update_location_details loc, loc.cl_warehouse_id, loc.cl_barcode            
           else
             existloc.update_attributes({
                             :client_id => (row_array[0].to_s.encode! 'utf-8'),                            
                             :cl_warehouse_id   => (row_array[1].to_s.encode! 'utf-8'),
                             :cl_barcode  =>(row_array[2].to_s.encode! 'utf-8'),
                             :current_item => (row_array[3].to_s.encode! 'utf-8'),
                             :current_quantity => (row_array[4].to_s.encode! 'utf-8'),
                             :life_time_total_picks  => (row_array[5].to_s.encode! 'utf-8'),
                             :lock_code => (row_array[6].to_s.encode! 'utf-8'),
                             :maximum_quantity =>(row_array[7].to_s.encode! 'utf-8'),
                             :minimum_quantity => (row_array[8].to_s.encode! 'utf-8'),
                             :status => (row_array[9].to_s.encode! 'utf-8')
                           
                                           })
             Location.update_location_details existloc, existloc.cl_warehouse_id, existloc.cl_barcode           

           end
                       
      else
      
        locationerror = Locationerror.new(
                           :file_name => filename + Time.now.to_s,
                           :error_description => error,
                           :attribute1 => (row_array[0].to_s.encode! 'utf-8'),
                           :attribute2 => (row_array[1].to_s.encode! 'utf-8'), 
                           :attribute3 => (row_array[2].to_s.encode! 'utf-8'),
                           :attribute4 => (row_array[3].to_s.encode! 'utf-8'),
                           :attribute5 => (row_array[4].to_s.encode! 'utf-8'),
                           :attribute6 => (row_array[5].to_s.encode! 'utf-8'),
                           :attribute7 => (row_array[6].to_s.encode! 'utf-8'),
                           :attribute8 => (row_array[7].to_s.encode! 'utf-8'),
                           :attribute9 => (row_array[8].to_s.encode! 'utf-8'),
                           :attribute10 => (row_array[9].to_s.encode! 'utf-8')
                                          )
            locationerror.save
     end
  
end

 #
 # Is this valid Row?
 #
 def self.is_row_valid rowOfcsv
   
   error = ""
   
    #ClientId validation
    if client = User.where(client_id: rowOfcsv[0]).first.nil?
     error = "ClientId not found" 
   end 
   
   #warehouse validation
   if warehouse = Warehouse.where(cl_warehouse_id: rowOfcsv[1]).first.nil?
     error += (error.blank? ? "" : ",") + "Warehouse not found"
     
   end  
   #Barcode validation  
   if barcode = Position.where("cl_barcode = ? and  cl_warehouse_id = ?" , rowOfcsv[2], rowOfcsv[1]).first.nil?
     error += (error.blank? ? "" : ",") + "Barcode not found"
      
   end
   
   #current quantity Should be greater than or equal to minimum quantity and less than or equal to maximum quantity
   if rowOfcsv[4].to_i > rowOfcsv[7].to_i 
     error += (error.blank? ? "" : ",") + "Current quantity more than maximum quantity"
   end  
   
   if rowOfcsv[4].to_i < rowOfcsv[8].to_i 
     error += (error.blank? ? "" : ",") + "Current quantity less than the minimum quantity"      
   end
   
     return error
   end


 #
 #Update location
 #    
  def self.update_location_details loc, warehouse, barcode 
         pos = Position.where('cl_warehouse_id = ? and cl_barcode =? ', warehouse, barcode).first
         
         unless pos.nil?
             zone = Zone.where('cl_warehouse_id = ? and sm_zone_id = ? ', warehouse, pos.sm_zone_id).first
             aisle = Aisle.where('cl_warehouse_id = ? and sm_zone_id = ? and sm_aisle_id = ? ', warehouse, pos.sm_zone_id, pos.sm_aisle_id).first
             bay = Bay.where('cl_warehouse_id = ? and sm_zone_id =? and sm_aisle_id = ? and sm_bay_id = ? ', warehouse, pos.sm_zone_id, pos.sm_aisle_id, pos.sm_bay_id).first
             level = Level.where('cl_warehouse_id = ? and sm_zone_id =? and sm_aisle_id =? and sm_bay_id =? and sm_level_id = ? ', warehouse, pos.sm_zone_id, pos.sm_aisle_id, pos.sm_bay_id, pos.sm_level_id).first
             loc_seq_no = zone.attribute2 + '-' + aisle.attribute1 + '-' + bay.attribute5 + '-' +  level.attribute1 + '-' + pos.attribute3
             loc_priority  = '00' + '-' + Location.get_rating(aisle.attribute4) + '-' +Location.get_rating(bay.attribute4) + '-' + Location.get_rating(level.attribute4) + '-' + Location.get_rating(pos.attribute4)
             
             loc.update_attributes({
            
                    :sm_zone_id => pos.sm_zone_id,
                    :cl_zone_id => pos.cl_zone_id,
                    :sm_aisle_id => pos.sm_aisle_id,
                    :cl_aisle_id => pos.cl_aisle_id,
                    :sm_bay_id => pos.sm_bay_id,
                    :cl_bay_id => pos.cl_bay_id, 
                    :sm_level_id => pos.sm_level_id,
                    :cl_level_id => pos.cl_level_id, 
                    :sm_pos_id => pos.sm_pos_id,
                    :cl_pos_id => pos.cl_pos_id,
                    :location_priority => loc_priority,
                    :attribute2 => loc_seq_no
                 }) 
         end     


 end

 #
  # Get the priority for the rating
  #
 def self.get_rating (priority)
    
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

end
