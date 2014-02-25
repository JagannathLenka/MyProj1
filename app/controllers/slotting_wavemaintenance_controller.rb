class SlottingWavemaintenanceController < ApplicationController
  
  def index

     get_header_details  if !request.xhr?
         columns =  ['id', 'wave_number','preffered_warehouse', 'preffered_zone' , 'preffered_aisle','preffered_bay',
                     'preffered_level','preffered_position','preffered_slotting_rules','wave_status']
                     
          slotting_waves = SlottingWave.select("*").where(search_string)
                         .paginate(
                         :page     => params[:page],
                         :per_page => params[:rows],
                         :order    => order_by_from_params(params))
    
          
          
         if request.xhr?           
             render :json => json_for_jqgrid(slotting_waves, columns)
          end 
  end
  
  def search_string
      
      search_string =  "1 = 1"
      search_string += " and preffered_slotting_rules in (" + params[:rule_id] + ")"  if (!params[:rule_id].nil? and  !params[:rule_id].blank?)
      search_string += " and wave_status in (" + params[:wave_status] + ")"  if (!params[:wave_status].nil? and !params[:wave_status].blank?) 
      
      return search_string
  end
  
  
  def create
    
    case params[:oper]
    
        when "edit"
          slotting_waves = SlottingWave.find_by_id(params[:id])
          slotting_waves.update_attributes(params[:SlottingWave])
          
             
        when "add"
                  
           slotting_waves = SlottingWave.new(params[:SlottingWave]) 
           slotting_waves.preffered_warehouse = '*' if (params[:SlottingWave][:preferred_warehouse].blank?)
           slotting_waves.preffered_zone = '*' if (params[:SlottingWave][:preferred_zone].blank?)
           slotting_waves.preffered_aisle = '*' if (params[:SlottingWave][:preferred_aisle].blank?)
           slotting_waves.preffered_bay = '*' if (params[:SlottingWave][:preferred_bay].blank?)
           slotting_waves.preffered_level = '*' if (params[:SlottingWave][:preferred_level].blank?)
           slotting_waves.preffered_position = '*' if (params[:SlottingWave][:preferred_position].blank?)
           slotting_waves.save 
            
        
        when "del"
          
              params[:id].split(',').each do |id|
                SlottingWave.destroy(id.to_i)
             end 
          
        end
    
    if request.xhr?
         render :json => nil 
    end    
   
  end
  
  
 #Write the breadcrumbs
 def get_header_details
   
    
 end 
 
end
