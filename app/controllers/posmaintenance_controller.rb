class PosmaintenanceController < ApplicationController
  # GET /maintenance
  
  def index
    @columns =  ['id','sm_pos_id','cl_pos_id','sm_level_id','cl_level_id','sm_bay_id', 'cl_bay_id','client_id','description','sm_aisle_id','cl_aisle_id','level_id','sm_zone_id','cl_zone_id','sm_warehouse_id','cl_warehouse_id','sm_barcode','cl_barcode','attribute1', 'attribute2', 'attribute3', 'attribute4','attribute5','attribute6', 'attribute7','attribute8']
    @pos = Position.select(" id , sm_pos_id , cl_pos_id , sm_level_id , cl_level_id, sm_bay_id , cl_bay_id , client_id , description , sm_aisle_id , cl_aisle_id , level_id , sm_zone_id , cl_zone_id ,sm_warehouse_id , cl_warehouse_id , sm_barcode , cl_barcode, attribute1 , attribute2 , attribute3 , attribute4 , attribute5 , attribute6 , attribute7 , attribute8 ").where(:level_id => params[:id]).paginate(
      :page     => params[:page],
      :per_page => params[:rows],
      :order    => order_by_from_params(params))
      
     if request.xhr?
        #@invoices = 'ok'
        render :json => json_for_jqgrid(@pos, @columns)
     end
  

   end

 def create
   
  case params[:oper]
  when "edit"
        @pos = Position.find_by_id(params[:id])
        @pos.update_attributes({ 
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
        @pos= Position.new(:sm_pos_id =>  maximum_pos_add, 
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
        
         @pos.save 
         
         
end
    if request.xhr?
      render :json => @pos
    end
 end
 
 end
