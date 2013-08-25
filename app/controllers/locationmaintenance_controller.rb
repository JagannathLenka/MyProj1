class LocationmaintenanceController < ApplicationController
  # GET /maintenance
  
  def index
    get_header_details  if !request.xhr?
    columns =  ['id','sm_loc_id','cl_loc_id','sm_pos_id','cl_pos_id','sm_level_id','cl_level_id','sm_bay_id', 'cl_bay_id','sm_aisle_id','cl_aisle_id','sm_zone_id','cl_zone_id','sm_warehouse_id','cl_warehouse_id','sm_barcode','cl_barcode','client_id','current_item', 'current_quantity','life_time_total_picks', 'lock_code', 'maximum_quantity', 'minimum_quantity','status','attribute1', 'attribute2', 'attribute3', 'attribute4','attribute5','attribute6', 'attribute7','attribute8']
    loc = Location.select(" id , sm_loc_id , cl_loc_id , sm_pos_id , cl_pos_id , sm_level_id , cl_level_id , sm_bay_id , cl_bay_id , sm_aisle_id , cl_aisle_id , sm_zone_id , cl_zone_id , sm_warehouse_id , cl_warehouse_id , sm_barcode , cl_barcode , client_id , current_item , current_quantity , life_time_total_picks , lock_code , maximum_quantity , minimum_quantity , status , attribute1 , attribute2 , attribute3 , attribute4 , attribute5 , attribute6 , attribute7 , attribute8 ").paginate(
      :page     => params[:page],
      :per_page => params[:rows],
      :order    => order_by_from_params(params))
      
     if request.xhr?
        render :json => json_for_jqgrid(loc, columns)
     end
   end

 def create
   
  case params[:oper]
  when "edit"
       update_location
        
  when "add"
         loc = Location.find_by_id(params[:id])
        
        loc= Location.new(
                                   :cl_loc_id   => params[:cl_loc_id],
                                   :cl_warehouse_id   => params[:cl_warehouse_id],
                                   :current_item => params[:current_item],
                                   :current_quantity => params[:current_quantity],
                                   :life_time_total_picks  => params[:life_time_total_picks],
                                   :lock_code => params[:lock_code],
                                   :maximum_quantity => params[:maximum_quantity],
                                   :minimum_quantity => params[:minimum_quantity],
                                   :status => params[:status],
                                   :sm_barcode  => params[:sm_barcode],
                                   :cl_barcode  => params[:cl_barcode],
                                   :attribute1 => params[:attribute1],
                                   :attribute2 => params[:attribute2], 
                                   :attribute3 => params[:attribute3],
                                   :attribute4 => params[:attribute4],
                                   :attribute5 => params[:attribute5],
                                   :attribute6 => params[:attribute6],
                                   :attribute7 => params[:attribute7],
                                   :attribute8 => params[:attribute8]  
                         
                       )
        
         loc.save
           
             
   when "del"
               loc =  Location.destroy(params[:id].to_i)
           
   end
    
    
    if request.xhr?
        render :json => loc   
     end
 end
 
 def update_location
   
  loc = Location.find_by_id(params[:id])
        loc.update_attributes({ 
                                   :cl_loc_id   => params[:cl_pos_id],
                                   :cl_warehouse_id   => params[:cl_warehouse_id],
                                   :current_item => params[:current_item],
                                   :current_quantity => params[:current_quantity],
                                   :life_time_total_picks  => params[:life_time_total_picks],
                                   :lock_code => params[:lock_code],
                                   :maximum_quantity => params[:maximum_quantity],
                                   :minimum_quantity => params[:minimum_quantity],
                                   :status => params[:status],
                                   :sm_barcode  => params[:sm_barcode],
                                   :cl_barcode  => params[:cl_barcode],
                                   :attribute1 => params[:attribute1],
                                   :attribute2 => params[:attribute2], 
                                   :attribute3 => params[:attribute3],
                                   :attribute4 => params[:attribute4],
                                   :attribute5 => params[:attribute5],
                                   :attribute6 => params[:attribute6],
                                   :attribute7 => params[:attribute7],
                                   :attribute8 => params[:attribute8]    
                                })
    
                               
   end
      
 end

 def get_header_details

   if cookies[:userid].nil? 
               redirect_to "/login"
    else
      @userid = cookies[:userid]
    end
 
end
