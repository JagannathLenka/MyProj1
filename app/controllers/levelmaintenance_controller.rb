class LevelmaintenanceController < ApplicationController
    # GET /maintenance
  def index
    columns =  ['id','sm_level_id','cl_level_id','client_id','description', 'sm_bay_id','cl_bay_id','bay_id','no_of_pos_level','no_of_pos_level_hidden', 'sm_aisle_id','cl_aisle_id','sm_zone_id','cl_zone_id','sm_warehouse_id','cl_warehouse_id','attribute1', 'attribute2', 'attribute3', 'attribute4','attribute5','attribute6', 'attribute7','attribute8']
    level = Level.select(" id , sm_level_id ,cl_level_id ,client_id ,description , sm_bay_id , cl_bay_id , bay_id , no_of_pos_level ,no_of_pos_level as no_of_pos_level_hidden, sm_aisle_id , cl_aisle_id , sm_zone_id , cl_zone_id , sm_warehouse_id , cl_warehouse_id,attribute1 , attribute2 , attribute3 , attribute4 , attribute5 , attribute6 , attribute7 , attribute8 ").where(:bay_id => params[:id]).paginate(
      :page     => params[:page],
      :per_page => params[:rows],
      :order    => order_by_from_params(params))
  
    if request.xhr?
      
      render :json => json_for_jqgrid(level, columns)
    end
    get_header_details
  end

 def create
   
    case params[:oper]
  
    when "edit"
          level = Level.find_by_id(params[:id])
          level.update_attributes({                                   
                                     :cl_level_id => params[:cl_level_id],
                                     :description => params[:description],
                                     :no_of_pos_level => params[:no_of_pos_level],
                                     :attribute1 => params[:attribute1],
                                     :attribute2 => params[:attribute2], 
                                     :attribute3 => params[:attribute3],
                                     :attribute4 => params[:attribute4],
                                     :attribute5 => params[:attribute5],
                                     :attribute6 => params[:attribute6],
                                     :attribute7 => params[:attribute7],
                                     :attribute8 => params[:attribute8]    
                                         
            })
            create_pos level
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
                                       :no_of_pos_level => params[:no_of_pos_level],
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
           bays.update_attributes({
                                   :no_of_level_bay => bays.no_of_level_bay + 1
         })
           
           create_pos level
           
    when "del"
              pos = Level.destroy(params[:id].to_i)       
    end
  
      
      if request.xhr?
        render :json => level
      end

 end
 
 def create_pos level
 
   posvalue = params[:no_of_pos_level].to_i
   posvalue_hidden = params[:no_of_pos_level_hidden].to_i
   diff_posvalue = posvalue - posvalue_hidden
   max_pos = Position.where(:level_id => level.id).maximum("sm_pos_id").to_i
    if(posvalue > posvalue_hidden)
      (1..diff_posvalue).each do |p|
         @pos =Position.create(:sm_pos_id => max_pos + p,
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
                end     
    
        end

 end
 
 def get_header_details
   bay =   Bay.find_by_id(params["id"].to_i)
   aisle = Aisle.find_by_id(bay.aisle_id)
   zone  = Zone.find_by_id(aisle.zone_id)
   warehouse = Warehouse.find_by_id(zone.warehouse_id)


   add_breadcrumb warehouse.cl_warehouse_id, "/zonemaintenance?id="+ warehouse.id.to_s
   add_breadcrumb zone.cl_zone_id.blank? ? zone.sm_zone_id: zone.cl_zone_id, "/aislemaintenance?id="+ zone.id.to_s
   add_breadcrumb aisle.cl_aisle_id.blank? ?aisle.sm_aisle_id: aisle.cl_aisle_id, "/baysmaintenance?id="+ aisle.id.to_s
   add_breadcrumb bay.cl_bay_id.blank? ?bay.sm_bay_id: bay.cl_bay_id, "/levelmaintenance?id="+ bay.id.to_s

  end   

end
