class PosmaintenanceController < ApplicationController
  # GET /maintenance
  
  def index
    columns =  ['id','sm_pos_id','cl_pos_id','sm_level_id','cl_level_id','sm_bay_id', 'cl_bay_id','client_id','description','sm_aisle_id','cl_aisle_id','level_id','sm_zone_id','cl_zone_id','sm_warehouse_id','cl_warehouse_id','sm_barcode','cl_barcode','attribute1', 'attribute2', 'attribute3', 'attribute4','attribute5','attribute6', 'attribute7','attribute8']
    pos = Position.select(" id , sm_pos_id , cl_pos_id , sm_level_id , cl_level_id, sm_bay_id , cl_bay_id , client_id , description , sm_aisle_id , cl_aisle_id , level_id , sm_zone_id , cl_zone_id ,sm_warehouse_id , cl_warehouse_id , sm_barcode , cl_barcode, attribute1 , attribute2 , attribute3 , attribute4 , attribute5 , attribute6 , attribute7 , attribute8 ").where(:level_id => params[:id]).paginate(
      :page     => params[:page],
      :per_page => params[:rows],
      :order    => order_by_from_params(params))
      
     if request.xhr?
        #@invoices = 'ok'
        render :json => json_for_jqgrid(pos, columns)
     end
  
    get_header_details
   end

 def create
   
  case params[:oper]
  when "edit"
        pos = Position.find_by_id(params[:id])
        pos.update_attributes({ 
                                   :cl_pos_id   => params[:cl_pos_id],
                                   :description => params[:description],
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
                                
                                

  when "add"
        maximum_pos_add = Position.maximum("sm_pos_id").to_i + 1
        pos= Position.new(:sm_pos_id =>  maximum_pos_add, 
                         :cl_pos_id => params[:cl_pos_id],
                         :level_id     => params[:level_id],
                         :description  => params[:description],
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
        
         pos.save 
         
         
end
    if request.xhr?
      render :json => pos
    end
 end
 def get_header_details
   level = Level.find_by_id(params["id"].to_i)
   bay =   Bay.find_by_id(level.bay_id)
   aisle = Aisle.find_by_id(bay.aisle_id)
   zone  = Zone.find_by_id(aisle.zone_id)
   warehouse = Warehouse.find_by_id(zone.warehouse_id)


   add_breadcrumb warehouse.cl_warehouse_id, "/zonemaintenance?id="+ warehouse.id.to_s
   add_breadcrumb zone.cl_zone_id.blank? ? zone.sm_zone_id: zone.cl_zone_id, "/aislemaintenance?id="+ zone.id.to_s
   add_breadcrumb aisle.cl_aisle_id.blank? ?aisle.sm_aisle_id: aisle.cl_aisle_id, "/baysmaintenance?id="+ aisle.id.to_s
   add_breadcrumb bay.cl_bay_id.blank? ?bay.sm_bay_id: bay.cl_bay_id, "/levelmaintenance?id="+ bay.id.to_s
   add_breadcrumb level.cl_level_id.blank? ?level.sm_level_id: level.cl_level_id, "/posmaintenance?id="+ level.id.to_s

  end   
 
 end
