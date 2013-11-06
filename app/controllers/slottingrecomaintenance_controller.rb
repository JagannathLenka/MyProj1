require 'slott_items'
class SlottingrecomaintenanceController < ApplicationController
  
 # GET /Render the JQGrid for slotting recomendation
  def index

     get_header_details  if !request.xhr?
     columns =  ['id', 'item_number','quantity_to_be_slotted','preffered_warehouse', 'preffered_zone' ,
        'preffered_aisle','preffered_bay','preffered_level','preffered_position','preffered_slotting_rules','partial_slotting','location_recommended',
        'slotting_status']
                  
         selectParam = 'slotting_status = "Open"'


     slotting = Slottingrecommendation.select("*").where(selectParam).paginate(
                     :page     => params[:page],
                     :per_page => params[:rows],
                     :order    => order_by_from_params(params))

      
      
     if request.xhr? 
       render :json => json_for_jqgrid(slotting, columns)
     end

  end

 
 #Update the aisles and create bays and levels beased on the input from JQgrid
 def create
  
  @error = ""
  case params[:oper]
    when "edit"
         edit_slotting_reco_details 
                  
    when "add"
          slotting_reco= Slottingrecommendation.new(
                                     :item_number => params[:item_number], 
                                     :location_recommended => params[:location_recommended],
                                     :partial_slotting => params[:partial_slotting],
                                     :preffered_warehouse => (params[:preffered_warehouse].blank? ? '*' : params[:preffered_warehouse]),
                                     :preffered_zone => (params[:preffered_zone].blank? ? '*'           : params[:preffered_zone]),
                                     :preffered_aisle => (params[:preffered_aisle].blank? ? '*'         : params[:preffered_aisle]),
                                     :preffered_bay => (params[:preffered_bay].blank? ? '*'             : params[:preffered_bay]),
                                     :preffered_level => (params[:preffered_level].blank? ? '*'         : params[:preffered_level]),
                                     :preffered_position => (params[:preffered_position].blank? ? '*'   : params[:preffered_position]),
                                     :preffered_slotting_rules => (params[:preffered_slotting_rules].blank? ? '*':  params[:preffered_slotting_rules]),
                                     :quantity_to_be_slotted => params[:quantity_to_be_slotted],
                                     :slotting_status => params[:slotting_status]
                            )
          
           slotting_reco.save 
           
         
    when "del"
                Slottingrecommendation.destroy(params[:id].to_i)   
                
    when "slott"
      
                #slott_items = SlottingItems.new(params[:id])
                #slott_items.sort_items
                sort_items(params[:id])             
  end        
 
  #If it is a Ajax then send the json details    
  if request.xhr?
       if !@error.blank?        
          render :json => @error.to_json, status: 500
       else
          render :json => slotting_reco
       end
  end
 end

def sort_items(item_ids)
    
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
                  .joins("INNER JOIN itemmasters on 
                           slottingrecommendations.item_number = itemmasters.item_number")
                  .select("slottingrecommendations.*, 
                           itemmasters.velocity as velocity, 
                           itemmasters.attribute1 as putaway_type,
                           itemmasters.daily_forecast as daily_forecast")
                  .where(selection_criteria)
                  .order(sorting_criteria)
      

    to_be_slotted_item_list.each_with_index do |to_be_slotted_item, i|
         sorted[i] = to_be_slotted_item.attributes
    end         
      
    slott_items(sorted)      
  end
  

  def slott_items(to_be_slotted_item_list)
    
    selected_location = 'locations.cl_barcode not in ('
    to_be_slotted_item_list.each_with_index do|to_be_slotted_item , i|    
        position_requirement = ''
        position_requirement +=         "positions.cl_warehouse_id = " + "'" + to_be_slotted_item['preffered_warehouse'] + "'"        unless  to_be_slotted_item['preffered_warehouse'] == '*'
        position_requirement += " AND " + "positions.cl_zone_id = "      + "'" + to_be_slotted_item['preffered_zone'] + "'"           unless  to_be_slotted_item['preffered_zone'] == '*'
        position_requirement += " AND " + "positions.cl_aisle_id = "      + "'" + to_be_slotted_item['preffered_aisle'] + "'"         unless  to_be_slotted_item['preffered_aisle'] == '*'
        position_requirement += " AND " + "positions.cl_bay_id = "      + "'" + to_be_slotted_item['preffered_bay'] + "'"             unless  to_be_slotted_item['preffered_bay'] == '*'
        position_requirement += " AND " + "positions.cl_level_id = "      + "'" + to_be_slotted_item['preffered_level'] + "'"         unless  to_be_slotted_item['preffered_level'] == '*'
        position_requirement += " AND " + "positions.cl_pos_id = "      + "'" + to_be_slotted_item['preffered_position'] + "'"        unless  to_be_slotted_item['preffered_position'] == '*'
        
        location_requirement = ''
        location_requirement += "current_quantity =  0 " 
        location_requirement += " AND " + "locations.current_item ==" +  to_be_slotted_item["item_number"].to_s
        location_requirement += " AND " + "locations.maximum_quantity >=" +  to_be_slotted_item["quantity_to_be_slotted"].to_s
        location_requirement += " AND " + "locations.minimum_quantity <=" +  to_be_slotted_item["quantity_to_be_slotted"].to_s
        location_requirement += " AND " + "locations.attribute1 =" + "'" + to_be_slotted_item["putaway_type"].to_s + "'"
    
        case to_be_slotted_item["velocity"] 
            
          when  "A"
           # position_requirement += " AND " + "positions.attribute3 = 'Yes'"
             
          when "B"
            
             
          when "C"
          
        end
        logger.debug selected_location
        slotting_item = location_selection(position_requirement,location_requirement,selected_location) 
        preferred_location =  slotting_item.nil? ? "No suitable location " :   slotting_item.cl_barcode             
        slotting_reco = Slottingrecommendation.find(to_be_slotted_item["id"].to_i)
        slotting_reco.update_attributes({ :location_recommended => preferred_location })  
        selected_location += (i== 0) ? ("'" + preferred_location + "'") : (" , '" + preferred_location + "'" )
        
    end
 
 end
 
 def location_selection(position_requirement,location_requirement,selected_location)
   
          
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
                    .where( selected_location + ")" )
                    .order('locations.location_priority desc')
                    .first
                              
            return slotting_item
                              
 end
 
 
 def edit_slotting_reco_details
 
         slotting_reco = Slottingrecommendation.find_by_id(params[:id])  
         slotting_reco.update_attributes({ 
                                     :item_number => params[:item_number], 
                                     :location_recommended => params[:location_recommended],
                                     :partial_slotting => params[:partial_slotting],
                                     :preffered_warehouse => (params[:preffered_warehouse].blank? ? '*' : params[:preffered_warehouse]),
                                     :preffered_zone => (params[:preffered_zone].blank? ? '*'           : params[:preffered_zone]),
                                     :preffered_aisle => (params[:preffered_aisle].blank? ? '*'         : params[:preffered_aisle]),
                                     :preffered_bay => (params[:preffered_bay].blank? ? '*'             : params[:preffered_bay]),
                                     :preffered_level => (params[:preffered_level].blank? ? '*'         : params[:preffered_level]),
                                     :preffered_position => (params[:preffered_position].blank? ? '*'   : params[:preffered_position]),
                                     :preffered_slotting_rules => (params[:preffered_slotting_rules].blank? ? '*':  params[:preffered_slotting_rules]),
                                     :quantity_to_be_slotted => params[:quantity_to_be_slotted],
                                     :slotting_status => params[:slotting_status]
                                  })
                                  
 end
 
 #Write the breadcrumbs
 def get_header_details
   
end 
    
end
