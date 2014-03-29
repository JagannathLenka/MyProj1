class PosmaintenanceController < ApplicationController
  
  rescue_from Exception, :with => :error_render_method
  
  # GET /maintenance
  
  def index
    get_header_details  if !request.xhr?
    columns =  ['id','sm_pos_id','cl_pos_id','description','sm_level_id','cl_level_id','sm_bay_id', 'cl_bay_id','client_id','sm_aisle_id','cl_aisle_id','level_id','sm_zone_id','cl_zone_id','sm_warehouse_id','cl_warehouse_id','sm_barcode','cl_barcode','attribute1', 'attribute2', 'attribute3', 'attribute4','attribute5','attribute6', 'attribute7','attribute8']
    pos = Position.select(" id , sm_pos_id , cl_pos_id , description , sm_level_id , cl_level_id, sm_bay_id , cl_bay_id , client_id , sm_aisle_id , cl_aisle_id , level_id , sm_zone_id , cl_zone_id ,sm_warehouse_id , cl_warehouse_id , sm_barcode , cl_barcode, attribute1 , attribute2 , attribute3 , attribute4 , attribute5 , attribute6 , attribute7 , attribute8 ").where(:level_id => params[:id]).paginate(
      :page     => params[:page],
      :per_page => params[:rows],
      :order    => order_by_from_params(params))
      
     if request.xhr?
        render :json => json_for_jqgrid(pos, columns)
     end
   end

 def create
  
  @error = ""
  case params[:oper]
  when "edit"
      pos = Position.find(params[:id])
      pos.update_attributes({ 
                                   :cl_pos_id   => params[:cl_pos_id],
                                   #:description => params[:description],
                                   :sm_barcode  => params[:sm_barcode],
                                   :attribute1 => params[:attribute1],
                                   :attribute2 => params[:attribute2], 
                                   :attribute3 => params[:attribute3],
                                   :attribute4 => params[:attribute4],
                                   :attribute5 => params[:attribute5],
                                   :attribute6 => params[:attribute6],
                                   :attribute7 => params[:attribute7],
                                   :attribute8 => params[:attribute8]    
                                })
        
  when "add"
        pos = Position.find_by_id(params[:id])
        levels = Level.find_by_id(params[:pt_level_id].to_i)
        maximum_pos_id = Position.where(:level_id =>params[:pt_level_id]).maximum("sm_pos_id").to_i + 1
        pos= Position.new(:sm_pos_id =>  maximum_pos_id, 
                         :cl_pos_id => params[:cl_pos_id],
                         :sm_level_id => levels.sm_level_id,
                         :cl_level_id => levels.cl_level_id,
                         :sm_bay_id => levels.sm_bay_id,
                         :cl_bay_id => levels.cl_bay_id,
                         :sm_aisle_id => levels.sm_aisle_id,
                         :cl_aisle_id => levels.cl_aisle_id,
                         :sm_zone_id => levels.sm_zone_id,
                         :cl_zone_id => levels.cl_zone_id,
                         :sm_warehouse_id => levels.sm_warehouse_id,
                         :cl_warehouse_id => levels.cl_warehouse_id,
                         :level_id     => levels.id,
                         #:description  => params[:description],
                         :sm_barcode  => params[:sm_barcode],
                         :cl_barcode  => params[:cl_barcode],
                         :attribute1 => params[:attribute1],
                         :attribute2 => params[:attribute2], 
                         :attribute3 => levels.attribute4,
                         :attribute4 => params[:attribute4],
                         :attribute5 => params[:attribute5],
                         :attribute6 => params[:attribute6],
                         :attribute7 => params[:attribute7],
                         :attribute8 => params[:attribute8]    
                         
                       )
        
         pos.save
           @error = params[:cl_pos_id]+ ' ' + pos.errors.values[0][0] if pos.errors.count > 0
             
   when "del"
               pos =  Position.destroy(params[:id].to_i)
                        
              
   end
    
    
    if request.xhr?
      if !@error.blank?        
        render :json => @error.to_json, status: 500
      else
        render :json => pos   
      end
        
    end
 end

 
 

 def get_header_details

   if cookies[:userid].nil? 
               redirect_to "/login"
    else
      @userid = cookies[:userid]
    end

   level = Level.find_by_id(params["id"].to_i)
   bay =   Bay.find_by_id(level.bay_id)
   aisle = Aisle.find_by_id(bay.aisle_id)
   zone  = Zone.find_by_id(aisle.zone_id)
   warehouse = Warehouse.find_by_id(zone.warehouse_id)


   add_breadcrumb "Warehouse:" + warehouse.cl_warehouse_id, "/zonemaintenance?id="+ warehouse.id.to_s
   add_breadcrumb "Zone:" + (zone.cl_zone_id.blank? ? zone.sm_zone_id.to_s: zone.cl_zone_id), "/aislemaintenance?id="+ zone.id.to_s
   add_breadcrumb "Aisle:" + (aisle.cl_aisle_id.blank? ?aisle.sm_aisle_id.to_s : aisle.cl_aisle_id), "/baysmaintenance?id="+ aisle.id.to_s
   add_breadcrumb "Bay:" + (bay.cl_bay_id.blank? ? bay.sm_bay_id.to_s : bay.cl_bay_id), "/levelmaintenance?id="+ bay.id.to_s
   add_breadcrumb "Level:" + (level.cl_level_id.blank? ? level.sm_level_id.to_s : level.cl_level_id), "/posmaintenance?id="+ level.id.to_s
   @warehouse = warehouse.cl_warehouse_id
   @warehouse_description = warehouse.description
  end  
  
  #Error Handling
def error_render_method exception
      
      render :json => "Error: PLEASE CONTACT YOUR IT " + "\n" + exception.message , status: 500
      true
  end 
     
 
 end
