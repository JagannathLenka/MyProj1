class SlottingItems
  
  attr_reader :item_ids  # get the slotting ids
  
  def  initialize(item_ids)
     @item_ids = item_ids
  end
  
  def sort_items
    
   to_be_slotted_item_list = Hash.new(0)
   item_ids.each do |item_id|     #calling method item_ids and getting the value then using each  do method
     to_be_slotted_item  = Slottingrecommendation.find(item_id.to_i).attributes
     item = Itemmaster.where(:item_number => to_be_slotted_item['item_number'] ).first
     to_be_slotted_item['velocity'] = item.nil? ? 'Z' : item.velocity
     to_be_slotted_item['daily_forecast'] = item.nil? ? '0' : item.daily_forecast
     to_be_slotted_item['putaway_type'] = item.nil? ? '' : item.attribute1
     to_be_slotted_item_list = to_be_slotted_item_list.merge(item_id.to_s => to_be_slotted_item)
     
    end

      sorted = to_be_slotted_item_list.sort_by { |k, v| [v['putaway_type'],v['velocity'],v['daily_forecast']] }
      #logger.debug "list"
      #logger.debug to_be_slotted_item_list
      slott_items(sorted)
      
  end
  
  def slott_items(to_be_slotted_item_list)
    
    
    to_be_slotted_item_list.each do|k, to_be_slotted_item|
    
    position_requirement = ''
    position_requirement +=         "cl_warehouse_id = " + "'" + to_be_slotted_item['preffered_warehouse'] + "'" unless  to_be_slotted_item['preffered_warehouse'] == '*'
    position_requirement += " AND " + "cl_zone_id = "      + "'" + to_be_slotted_item['preffered_zone'] + "'"           unless  to_be_slotted_item['preffered_zone'] == '*'
    position_requirement += " AND " + "cl_aisle_id = "      + "'" + to_be_slotted_item['preffered_aisle'] + "'"           unless  to_be_slotted_item['preffered_aisle'] == '*'
    position_requirement += " AND " + "cl_bay_id = "      + "'" + to_be_slotted_item['preffered_bay'] + "'"           unless  to_be_slotted_item['preffered_bay'] == '*'
    position_requirement += " AND " + "cl_level_id = "      + "'" + to_be_slotted_item['preffered_level'] + "'"           unless  to_be_slotted_item['preffered_level'] == '*'
    position_requirement += " AND " + "cl_pos_id = "      + "'" + to_be_slotted_item['preffered_position'] + "'"           unless  to_be_slotted_item['preffered_position'] == '*'
    preferred_location = "No suitable Position"  

    case to_be_slotted_item["velocity"] 
        
      when  "A"
        position_requirement += " AND " + "attribute3 = 'Yes'" # attribute3 is from location table 
        pref_positions = Position.where(position_requirement)
        pref_positions.each do |pref_position|
           pref_location = Location.where('cl_warehouse_id = ? and cl_barcode = ? and current_quantity = ? and maximum_quantity >= ? and minimum_quantity <= ? and attribute1 = ?' , 
                                         pref_position.cl_warehouse_id , pref_position.cl_barcode , 0 , to_be_slotted_item["quantity_to_be_slotted"] , to_be_slotted_item["quantity_to_be_slotted"] , to_be_slotted_item["putaway_type"]).first
           preferred_location = pref_location.nil? ? "No suitable Location" : pref_location.cl_barcode 
           break unless pref_location.nil?    
        end
        slotting_item = Slottingrecommendation.find(to_be_slotted_item["id"].to_i)
        slotting_item.update_attributes({ :location_recommended =>  preferred_location })  
  
             
              
      when "B"
        
        
      when "C"
      
      end
        
    end
    
  end
 
  
end