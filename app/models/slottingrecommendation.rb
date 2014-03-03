require 'csv'
class Slottingrecommendation < ActiveRecord::Base
  attr_accessible :attribute1, :attribute2, :attribute3, :attribute4, :attribute5, :attribute6, :attribute7, :attribute8, :client_id, :item_number, :location_recommended, :partial_slotting, :preffered_aisle, :preffered_bay, :preffered_level, :preffered_position, :preffered_slotting_rules, :preffered_warehouse, :preffered_zone, :quantity_to_be_slotted, :slotting_status

    def self.to_csv(options = {})
      CSV.generate(options) do |csv|
        csv << column_names
        all.each do |slottingrecommendation|
          csv << slottingrecommendation.attributes.values_at(*column_names)
        end
      end
    end

    def self.sort_items(item_ids)
        
       to_be_slotted_item_list = Hash.new(0)
    
    
       #Create the selection for ids to be selected
       selection_criteria = 'slottingrecommendations.id in ('   
       item_ids.each_with_index do |id, i|
          selection_criteria +=  (i < item_ids.length-1) ? ( id + ',') : (id + ')')         
       end
          
       #Create the sorting criteria dynamically
        sorting_criteria = 'putaway_type, velocity, daily_forecast'        
        sorted = Array.new(0)
    
       to_be_slotted_item_list = Slottingrecommendation
                      .joins("LEFT OUTER JOIN itemmasters on 
                               slottingrecommendations.item_number = itemmasters.item_number")
                      .select("slottingrecommendations.*,
                               itemmasters.item_number as item_master_item,  
                               itemmasters.velocity as velocity, 
                               itemmasters.attribute1 as putaway_type,
                               itemmasters.daily_forecast as daily_forecast")
                      .where(selection_criteria)
                      .order(sorting_criteria)
          
    
        to_be_slotted_item_list.each_with_index do |to_be_slotted_item, i|
             sorted[i] = to_be_slotted_item.attributes
        end         
          
        self.slott_items(sorted)      
      end
    
  def self.slott_items(to_be_slotted_item_list)
    
    selected_location = Array.new(0)
    selected_location.clear
    logger.debug selected_location
    
    #selected_location = "locations.cl_barcode not in ('"
    to_be_slotted_item_list.each_with_index do|to_be_slotted_item , i|    
        position_requirement = ''
        position_requirement +=         "positions.cl_warehouse_id = " + "'" + to_be_slotted_item['preffered_warehouse'] + "'"        unless  to_be_slotted_item['preffered_warehouse'] == '*'
        position_requirement += " AND " + "positions.cl_zone_id = "      + "'" + to_be_slotted_item['preffered_zone'] + "'"           unless  to_be_slotted_item['preffered_zone'] == '*'
        position_requirement += " AND " + "positions.cl_aisle_id = "      + "'" + to_be_slotted_item['preffered_aisle'] + "'"         unless  to_be_slotted_item['preffered_aisle'] == '*'
        position_requirement += " AND " + "positions.cl_bay_id = "      + "'" + to_be_slotted_item['preffered_bay'] + "'"             unless  to_be_slotted_item['preffered_bay'] == '*'
        position_requirement += " AND " + "positions.cl_level_id = "      + "'" + to_be_slotted_item['preffered_level'] + "'"         unless  to_be_slotted_item['preffered_level'] == '*'
        position_requirement += " AND " + "positions.cl_pos_id = "      + "'" + to_be_slotted_item['preffered_position'] + "'"        unless  to_be_slotted_item['preffered_position'] == '*'
        
        #pass 1
        logger.debug 'Pass1'
        location_requirement = ''
        location_requirement += "(current_quantity =  0 OR current_quantity IS NULL) " 
        location_requirement += " AND " + "locations.current_item ='" +  to_be_slotted_item["item_number"].to_s + "'"
        location_requirement += " AND " + "locations.maximum_quantity >=" +  to_be_slotted_item["quantity_to_be_slotted"].to_s
        location_requirement += " AND " + "locations.minimum_quantity <=" +  to_be_slotted_item["quantity_to_be_slotted"].to_s
        location_requirement += " AND " + "locations.attribute1 =" + "'" + to_be_slotted_item["putaway_type"].to_s + "'"
    
       
       slotting_item = self.location_selection(position_requirement,location_requirement,self.already_selected(selected_location))
        
        #pass 2
        logger.debug 'Pass2'
        if (slotting_item.nil?)
          
            location_requirement = ''
            location_requirement += "(current_quantity =  0 OR current_quantity IS NULL) " 
            location_requirement += " AND " + "(locations.current_item = '' OR locations.current_item IS NULL )"
            location_requirement += " AND " + "locations.attribute1 =" + "'" + to_be_slotted_item["putaway_type"].to_s + "'"        
            slotting_item = self.location_selection(position_requirement,location_requirement,self.already_selected(selected_location))
        end
        
        case 
                  
        when to_be_slotted_item["item_master_item"].nil?
              preferred_location =  "Invalid Item"  

        when slotting_item.nil?
            preferred_location =   "No suitable location "  
              
        else                
        preferred_location =  slotting_item.cl_barcode  
        selected_location << preferred_location
        end
                    
        slotting_reco = Slottingrecommendation.find(to_be_slotted_item["id"].to_i)
        slotting_reco.update_attributes({ :location_recommended => preferred_location })  
      
        
    end
    
     

  end

  def self.already_selected(selected_location)
    
        selected_location_query_string = "locations.cl_barcode not in ("
        selected_location.each_with_index do |preffered_location , i|
          
          selected_location_query_string += (i== 0) ? ( "'" +  preffered_location + "'" ) : (" , '" +  preffered_location + "'")
          
        end
       puts selected_location.length 
       selected_location_query_string += (selected_location.length > 0) ?  ")" : "' ')"
       
       return  selected_location_query_string
  end
   
  def self.location_selection(position_requirement,location_requirement,selected_location)
   
          
           slotting_item = Location
                    .joins("INNER JOIN positions on
                            locations.cl_barcode = positions.cl_barcode AND
                            locations.cl_warehouse_id = positions.cl_warehouse_id ")
                    .select("locations.*,
                              positions.cl_zone_id,
                              positions.cl_aisle_id,
                              positions.cl_bay_id,
                              positions.cl_level_id")
                    .where( position_requirement)
                    .where( location_requirement)
                    .where( selected_location )
                    .order('locations.location_priority desc, locations.attribute2 asc')
                    .first
            puts position_requirement + ' ' + location_requirement                  
            return slotting_item
                              
    end
 
  
end