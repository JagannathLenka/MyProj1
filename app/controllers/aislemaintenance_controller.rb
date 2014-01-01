require 'copy_object'
class AislemaintenanceController < ApplicationController
 
#rescue_from Exception, :with => :error_render_method

 include CopyObject
  
 # GET /Render the JQGrid for aisle maintenance
  def index
    
      if params["aisleid"].blank?
          #Get the header details of the zone
          get_header_details
      end
      

     columns =  ['id','sm_aisle_id', 'cl_aisle_id','description','client_id', 'sm_zone_id','cl_zone_id','zone_id',
                  'sm_warehouse_id' ,'cl_warehouse_id', 'no_of_bays_aisle', 'no_of_bays_aisle_hidden','no_of_levels_aisle','no_of_levels_aisle_hidden',
                  'attribute3','attribute4', 'attribute1', 'attribute2' , 
                  'attribute5','attribute6','attribute7','attribute8']
                  
     selectParam = params["aisleid"].blank? ? {:zone_id => params[:id]} : {:id => params["aisleid"].to_i}


     aisles = Aisle.select(" id ,sm_aisle_id , cl_aisle_id , description ,client_id , sm_zone_id ,cl_zone_id , zone_id ,
                    sm_warehouse_id , cl_warehouse_id,no_of_bays_aisle ,no_of_bays_aisle as no_of_bays_aisle_hidden,no_of_levels_aisle,no_of_levels_aisle as no_of_levels_aisle_hidden,
                    attribute3 , attribute4 , attribute1 , attribute2 ,
                    attribute5, attribute6 , attribute7 , attribute8 ").where(selectParam).paginate(
                     :page     => params[:page],
                     :per_page => params[:rows],
                     :order    => order_by_from_params(params))

      
      
     if request.xhr? and params[:lightweight] != "yes"
       render :json => json_for_jqgrid(aisles, columns)
     end

  end

 
 #Update the aisles and create bays and levels beased on the input from JQgrid
 def create
  
  @error = ""
  case params[:oper]
  when "edit"
       edit_aisle_details 
                
  when "add"
        aisles = Aisle.find_by_id(params[:id])
        zone = Zone.find_by_id(params[:pt_zone_id].to_i)
        maximum_aisle_id = Aisle.where(:zone_id => params[:pt_zone_id]).maximum("sm_aisle_id").to_i + 1
        aisles= Aisle.new(:sm_aisle_id => maximum_aisle_id, 
                                   :cl_aisle_id => params[:cl_aisle_id],
                                   :sm_zone_id => zone.sm_zone_id,
                                   :cl_zone_id => zone.cl_zone_id,
                                   :sm_warehouse_id => zone.sm_warehouse_id,
                                   :cl_warehouse_id => zone.cl_warehouse_id,
                                   :zone_id => zone.id,
                                   :description  => params[:description],
                                   :no_of_bays_aisle => 0,
                                   :no_of_levels_aisle => params[:no_of_levels_aisle],
                                   :attribute1 => params[:attribute1],
                                   :attribute2 => params[:attribute2], 
                                   :attribute3 => params[:attribute3],
                                   :attribute4 => params[:attribute4],
                                   :attribute5 => params[:attribute5],
                                   :attribute6 => params[:attribute6],
                                   :attribute7 => params[:attribute7],
                                   :attribute8 => params[:attribute8]   
                          )
        
         aisles.save 
         @error = params[:cl_aisle_id]+ ' ' + aisles.errors.values[0][0] if aisles.errors.count > 0 
         add_bays_to_aisle aisles if aisles.errors.count <= 0 
         
  when "del"
              Aisle.destroy(params[:id].to_i)   
              
  when "cpy"
             
              CopyObject.copyAisletoZone params[:id]
           
 end        
    #If it is a Ajax then send the json details
    if request.xhr?
       if !@error.blank?        
        render :json => @error.to_json, status: 500
       else
      render :json => aisles
    end
   end 
 end
 
 
 def edit_aisle_details
 
        aisles = Aisle.find_by_id(params[:id].to_i)
        aisles.update_attributes({ 
                                   :cl_aisle_id => params[:cl_aisle_id],
                                   :description    => params[:description],
                                   :no_of_bays_aisle => params[:no_of_bays_aisle],
                                   :no_of_levels_aisle => params[:no_of_levels_aisle],
                                   :attribute1 => params[:attribute1],
                                   :attribute2 => params[:attribute2], 
                                   :attribute3 => params[:attribute3],
                                   :attribute4 => params[:attribute4],
                                   :attribute5 => params[:attribute5],
                                   :attribute6 => params[:attribute6],
                                   :attribute7 => params[:attribute7],
                                   :attribute8 => params[:attribute8]    
                                  })
                                  
       @error = params[:cl_aisle_id]+ ' ' + aisles.errors.values[0][0] if aisles.errors.count > 0                            

 end
 
 #Write the breadcrumbs
 def get_header_details
   
   zone  = Zone.find_by_id(params["id"].to_i)
   warehouse = Warehouse.find_by_id(zone.warehouse_id)
   @warehouse = warehouse.cl_warehouse_id
   @warehouse_description = warehouse.description
   add_breadcrumb warehouse.cl_warehouse_id, "/zonemaintenance?id="+ warehouse.id.to_s
   add_breadcrumb zone.cl_zone_id.blank? ? zone.sm_zone_id: zone.cl_zone_id, "/aislemaintenance?id="+ zone.id.to_s
end 
    
#Error Handling
def error_render_method exception
      
      render :json => "Error: PLEASE CONTACT YOUR IT " + "\n" + exception.message , status: 500
      true
  end 
     
end
