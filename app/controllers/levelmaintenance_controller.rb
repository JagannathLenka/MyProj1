require 'copy_object'
class LevelmaintenanceController < ApplicationController
  include CopyObject
    # GET /maintenance
  def index
    get_header_details
    columns =  ['id','sm_level_id','cl_level_id','description','client_id', 'sm_bay_id','cl_bay_id','bay_id','no_of_pos_level','no_of_pos_level_hidden', 'sm_aisle_id','cl_aisle_id','sm_zone_id','cl_zone_id','sm_warehouse_id','cl_warehouse_id','attribute1', 'attribute2', 'attribute3', 'attribute4','attribute5','attribute6', 'attribute7','attribute8']
    level = Level.select(" id , sm_level_id ,cl_level_id ,description , client_id , sm_bay_id , cl_bay_id , bay_id , no_of_pos_level ,no_of_pos_level as no_of_pos_level_hidden, sm_aisle_id , cl_aisle_id , sm_zone_id , cl_zone_id , sm_warehouse_id , cl_warehouse_id,attribute1 , attribute2 , attribute3 , attribute4 , attribute5 , attribute6 , attribute7 , attribute8 ").where(:bay_id => params[:id]).paginate(
      :page     => params[:page],
      :per_page => params[:rows],
      :order    => order_by_from_params(params))
  
    if request.xhr?
      
      render :json => json_for_jqgrid(level, columns)
    end
    
  end

 def create
   
    @error = ""
    case params[:oper]
  
    when "edit"
          edit_level_details
          
          
    when "add"

           level = Level.find_by_id(params[:id])
           bays = Bay.find_by_id(params[:pt_bay_id].to_i)             
           maximum_level_id = Level.where(:bay_id => params[:pt_bay_id]).maximum("sm_level_id").to_i + 1
           level= Level.new(:sm_level_id => maximum_level_id,
                                       :cl_level_id => params[:cl_level_id],
                                       :sm_bay_id => bays.sm_bay_id,
                                       :cl_bay_id => bays.cl_bay_id,
                                       :sm_aisle_id => bays.sm_aisle_id,
                                       :cl_aisle_id => bays.cl_aisle_id,
                                       :sm_zone_id => bays.sm_zone_id,
                                       :cl_zone_id => bays.cl_zone_id,
                                       :sm_warehouse_id => bays.sm_warehouse_id,
                                       :cl_warehouse_id => bays.cl_warehouse_id,
                                       :bay_id    => bays.id,
                                       :description => params[:description],
                                       :no_of_pos_level => 0,
                                       :attribute1 => params[:attribute1],
                                       :attribute2 => params[:attribute2], 
                                       :attribute3 => params[:attribute3],
                                       :attribute4 => params[:attribute4],
                                       :attribute5 => params[:attribute5],
                                       :attribute6 => params[:attribute6],
                                       :attribute7 => params[:attribute7],
                                       :attribute8 => params[:attribute8] 
                ) 
                
       level.save 
       
       @error = params[:cl_level_id]+ ' ' + level.errors.values[0][0] if level.errors.count > 0   
       add_pos_to_level level if level.errors.count <= 0  
        
    when "del"
               level=Level.destroy(params[:id].to_i) 
               
    when "cpy"
             
             CopyObject.copyLeveltoBay params[:id]           
              
    end
  
      
   if request.xhr?
      if !@error.blank?        
        render :json => @error.to_json, status: 500
       else
        render :json => level
      end
    end  
 end
 
 def edit_level_details
   level = Level.find_by_id(params[:id])
   case 
        
        #add in the number of Positions
        when params[:no_of_pos_level].to_i >  (level.no_of_pos_level.nil? ? 0 : level.no_of_pos_level)
             add_pos_to_level level
             
             
        #delete in the number of Positions
        when params[:no_of_pos_level].to_i <  (level.no_of_pos_level.nil? ? 0 : level.no_of_pos_level)
             remove_pos_from_level level
             
       end 
       level.update_attributes({                                   
                                     :cl_level_id => params[:cl_level_id],
                                     :description => params[:description],
                                     :attribute1 => params[:attribute1],
                                     :attribute2 => params[:attribute2], 
                                     :attribute3 => params[:attribute3],
                                     :attribute4 => params[:attribute4],
                                     :attribute5 => params[:attribute5],
                                     :attribute6 => params[:attribute6],
                                     :attribute7 => params[:attribute7],
                                     :attribute8 => params[:attribute8]    
                                         
            })
            
      @error = params[:cl_level_id]+ ' ' + level.errors.values[0][0] if level.errors.count > 0   
             
 end
 
 def add_pos_to_level level
   
   max_pos = Position.where(:level_id => level.id).maximum("sm_pos_id").to_i
   newpos = params[:no_of_pos_level].to_i
   existingpos = level.no_of_pos_level.nil? ? 0 : level.no_of_pos_level
   diff_posvalue = newpos - existingpos
  
     
      (1..diff_posvalue).each do |p|
        pos =Position.new(:sm_pos_id => max_pos + p,
                         :sm_level_id => level.sm_level_id,
                         :sm_bay_id => level.sm_bay_id,
                         :sm_aisle_id => level.sm_aisle_id,
                         :sm_zone_id => level.sm_zone_id,
                         :sm_warehouse_id => level.sm_warehouse_id,
                         :sm_barcode => "",
                         :level_id => level.id,
                         :cl_barcode => "",
                         :cl_pos_id => "",
                         :cl_level_id => level.cl_level_id,
                         :cl_bay_id => level.cl_bay_id,
                         :cl_aisle_id => level.cl_aisle_id,
                         :cl_zone_id => level.cl_zone_id,
                         :cl_warehouse_id => level.cl_warehouse_id
                           
                     )
          pos.save
                end    
 end
 
 def remove_pos_from_level level
   newpos = params[:no_of_pos_level].to_i
   existingpos = level.no_of_pos_level
   diff_posvalue = existingpos - newpos
          (1..diff_posvalue).each do |p|
                 Position.where(:level_id => level.id).last.destroy
            end    
 end
 
 
 def get_header_details
  
   bay =   Bay.find_by_id(params["id"].to_i)
   aisle = Aisle.find_by_id(bay.aisle_id)
   zone  = Zone.find_by_id(aisle.zone_id)
   warehouse = Warehouse.find_by_id(zone.warehouse_id)


   add_breadcrumb "Warehouse:" + warehouse.cl_warehouse_id, "/zonemaintenance?id="+ warehouse.id.to_s
   add_breadcrumb "Zone:" + (zone.cl_zone_id.blank? ? zone.sm_zone_id.to_s: zone.cl_zone_id), "/aislemaintenance?id="+ zone.id.to_s
   add_breadcrumb "Aisle:" + (aisle.cl_aisle_id.blank? ?aisle.sm_aisle_id.to_s: aisle.cl_aisle_id), "/baysmaintenance?id="+ aisle.id.to_s
   add_breadcrumb "Bay:" + (bay.cl_bay_id.blank? ?bay.sm_bay_id.to_s: bay.cl_bay_id), "/levelmaintenance?id="+ bay.id.to_s
   @warehouse = warehouse.cl_warehouse_id
   @warehouse_description = warehouse.description
  end   

end
