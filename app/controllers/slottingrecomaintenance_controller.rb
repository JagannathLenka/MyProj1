require 'csv'
class SlottingrecomaintenanceController < ApplicationController
  
#rescue_from Exception, :with => :error_render_method
  
 # GET /Render the JQGrid for slotting recomendation
  def index

     get_header_details  if !request.xhr?
     columns =  ['id', 'item_number','quantity_to_be_slotted','preffered_warehouse', 'preffered_zone' ,
        'preffered_aisle','preffered_bay','preffered_level','preffered_position','preffered_slotting_rules','partial_slotting','location_recommended',
        'slotting_status','attribute2']
                  
         selectParam = "slotting_status in ('Open' , 'Allocate')" 
         (selectParam += "and attribute1 = '" + params[:id] + "'" ) if !params[:id].nil? 

        


     slotting = Slottingrecommendation.select("*")
                 .where(selectParam)
                  .paginate(
                     :page     => params[:page],
                     :per_page => params[:rows],
                     :order    => order_by_from_params(params))

      
      
     if request.xhr? 
       render :json => json_for_jqgrid(slotting, columns)
     else
       respond_to do |format|
          format.html
          format.csv { send_data slotting.to_csv, filename: "slotting_data.csv" }
        end
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
                                     :quantity_to_be_slotted => (params[:quantity_to_be_slotted].blank? ? 0: params[:quantity_to_be_slotted]),
                                     :slotting_status => params[:slotting_status],
                                     :attribute2 => params[:attribute2]
                            )
          
           slotting_reco.save 
           
         
    when "del"
                 
                 params[:id].split(',').each do |id|
                   
                   Slottingrecommendation.destroy(id.to_i)
                   
                 end
                 
    when "slott"
      
                #slott_items = SlottingItems.new(params[:id])
                #slott_items.sort_items
                Slottingrecommendation.sort_items(params[:id])             
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
                                     :quantity_to_be_slotted => (params[:quantity_to_be_slotted].blank? ? 0: params[:quantity_to_be_slotted]),
                                     :slotting_status => params[:slotting_status]
                                  })
                                  
 end
 
#Write the breadcrumbs
def get_header_details    
  
end
  
    
#Error Handling
def error_render_method exception
      
      render :json => "Error: PLEASE CONTACT YOUR IT " + "\n" + exception.message , status: 500
      true
  end 
    
end
