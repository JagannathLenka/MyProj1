class WarehousemaintenanceController < ApplicationController
   # GET /maintenance
  def index

    @columns =  ['id','sm_warehouse_id', 'cl_warehouse_id','client_id','description', 'no_of_zones','no_of_zones_hidden', 'atrribute1','atrribute2','atrribute3','atrribute4','atrribute5','atrribute6','atrribute7','atrribute8' ]
    @warehouse = Warehouse.select(" id ,sm_warehouse_id , cl_warehouse_id ,client_id , description , no_of_zones , no_of_zones as no_of_zones_hidden , atrribute1 , atrribute2 , atrribute3 , atrribute4, atrribute5, atrribute6 , atrribute7 , atrribute8 ").paginate(
      :page     => params[:page],
      :per_page => params[:rows],
      :order    => order_by_from_params(params))
  
    if request.xhr?
      #@invoices = 'ok'
      render :json => json_for_jqgrid(@warehouse, @columns)
    end

  end


 #POST /warehousemaintenance
 #Creates the warehouse and the zones
 def create
   
  case params[:oper]
  when "edit"
        @warehouse = Warehouse.find_by_id(params[:id])
        @warehouse.update_atrributes({
                                   :cl_warehouse_id => params[:cl_warehouse_id], 
                                   :client_id => params[:client_id],
                                   :description => params[:description],
                                   :no_of_zones => params[:no_of_zones],
                                   :atrribute1 => params[:atrribute1],
                                   :atrribute2 => params[:atrribute2], 
                                   :atrribute3 => params[:atrribute3],
                                   :atrribute4 => params[:atrribute4]
                                        
          })

  when "add"
        maximum_warehouse_id = Warehouse.maximum("sm_warehouse_id").to_i + 1
        @warehouse= Warehouse.new( :sm_warehouse_id => maximum_warehouse_id ,
                                   :cl_warehouse_id => params[:cl_warehouse_id], 
                                   :client_id => params[:client_id],
                                   :description => params[:description],
                                   :no_of_zones => params[:no_of_zones],
                                   :atrribute1 => params[:atrribute1],
                                   :atrribute2 => params[:atrribute2], 
                                   :atrribute3 => params[:atrribute3],
                                   :atrribute4 => params[:atrribute4]
          )
        
         @warehouse.save 
         
         
         zonevalue = params[:no_of_zones].to_i
         hidden_zonevalue = params[:no_of_zones_hidden].to_i
         max_zone = Zone.where(:warehouse_id => params[:id]).maximum("sm_zone_id")
         if(zonevalue > hidden_zonevalue)
         diff_zonevalue = zonevalue - hidden_zonevalue
         
         (1..diff_zonevalue).each do |z| 
         
                     Zone.create(
                                  :sm_warehouse_id => maximum_warehouse_id ,
                                  :warehouse_id => @warehouse.id,
                                  :cl_warehouse_id => params[:cl_warehouse_id]
                               )
                           end 
                           
          end                 
                               
end
    if request.xhr?
      render :json => @warehouse
    end
 end
end
