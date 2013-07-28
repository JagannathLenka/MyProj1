class ZonemaintenanceController < ApplicationController
   # GET /zonemaintenance
  def index

    columns =         ['id','sm_zone_id','cl_zone_id','client_id','sm_warehouse_id','cl_warehouse_id',
                        'warehouse_id','description', 'no_of_aisles_zone', 'no_of_aisles_zone_hidden', 'no_of_bays_aisle','no_of_levels_aisle', 
                        'attribute1', 'attribute2', 'attribute3','attribute4','attribute5','attribute6','attribute7','attribute8']
   
    zone = Zone.select("id , sm_zone_id , cl_zone_id , client_id ,sm_warehouse_id , cl_warehouse_id, 
                          warehouse_id ,description , no_of_aisles_zone,no_of_aisles_zone as no_of_aisles_zone_hidden,  no_of_bays_aisle, no_of_levels_aisle  ,
                          attribute1, attribute2, attribute3 , attribute4 , attribute5, attribute6, attribute7 , attribute8").where(:warehouse_id => params[:id]).paginate(
    
      :page     => params[:page],
      :per_page => params[:rows],
      :order    => order_by_from_params(params))
   
    #Get the header details of the zone
    get_header_details
      
    if request.xhr? 
      
      render :json => json_for_jqgrid(zone, columns)
    end

  end
  
#POST Edit Zones and Add/Edit ailses 
 def create
   
    case params[:oper]
  
    when "edit"
          zone = Zone.find_by_id(params[:id])
          zone.update_attributes({ 
                                     :cl_zone_id => params[:cl_zone_id],
                                     :description => params[:description],
                                     :no_of_aisles_zone => params[:no_of_aisles_zone],
                                     :attribute1 => params[:attribute1],
                                     :attribute2 => params[:attribute2], 
                                     :attribute3 => params[:attribute3],
                                     :attribute4 => params[:attribute4],
                                     :attribute5 => params[:attribute5],
                                     :attribute6 => params[:attribute6],
                                     :attribute7 => params[:attribute7],
                                     :attribute8 => params[:attribute8]    
            })
           create_aisles zone
           
    when "add"
          warehouse = Warehouse.find_by_id(params[:pt_warehouse_id])         
          zone = Zone.find_by_id(params[:id]) 
          maximum_zone_id =  Zone.where(:warehouse_id => params[:pt_warehouse_id]).maximum("sm_zone_id").to_i + 1
          zone= Zone.new(            :sm_zone_id => maximum_zone_id, 
                                     :sm_warehouse_id => warehouse.sm_warehouse_id,  
                                     :warehouse_id  => warehouse.id,                                   
                                     :cl_zone_id => params[:cl_zone_id],
                                     :cl_warehouse_id => warehouse.cl_warehouse_id,
                                     :description => params[:description],
                                     :no_of_aisles_zone => params[:no_of_aisles_zone],
                                     :attribute1 => params[:attribute1],
                                     :attribute2 => params[:attribute2], 
                                     :attribute3 => params[:attribute3],
                                     :attribute4 => params[:attribute4],
                                     :attribute5 => params[:attribute5],
                                     :attribute6 => params[:attribute6],
                                     :attribute7 => params[:attribute7],
                                     :attribute8 => params[:attribute8]    

            )
           zone.save
           warehouse.update_attributes({
                                   :no_of_zones => warehouse.no_of_zones + 1
         })
               
           create_aisles zone
    end
  
      
      if request.xhr?
        render :json => zone
      end
end

 #Create Aisles based on the parameters given by user in the form edit screen
 def create_aisles zone

         aislevalue = params[:no_of_aisles_zone].to_i
         hidden_aislevalue = params[:no_of_aisles_zone_hidden].to_i
         bayvalue = params[:no_of_bays_aisle].to_i
         max_aisle = Aisle.where(:zone_id => params[:id]).maximum("sm_aisle_id").to_i
         if(aislevalue > hidden_aislevalue)
           diff_aislevalue = aislevalue - hidden_aislevalue
           (1..diff_aislevalue).each do |a|
            aisles  = Aisle.new(:sm_aisle_id       => max_aisle + a,
                              :sm_zone_id         => zone.sm_zone_id,
                              :sm_warehouse_id    => zone.sm_warehouse_id,
                              :zone_id            => zone.id,
                              :no_of_bays_aisle   => params[:no_of_bays_aisle],
                              :cl_aisle_id        => "",
                              :cl_zone_id         => zone.cl_zone_id,
                              :cl_warehouse_id    => zone.cl_warehouse_id
                              
                          )
             aisles.save
          end
        else        
        
        #When there is no change in aisle value but just change in other parameters
        aisles_set = Aisle.where(:zone_id => zone.id)
        aisles_set.each do |aisles| 
                  aisles.update_attributes({ 
                                  :cl_zone_id         => zone.cl_zone_id,
                                  :cl_warehouse_id    => zone.cl_warehouse_id
                                  })
                  end      
        end         
    end


  def get_header_details
    warehouse  = Warehouse.find_by_id(params["id"].to_i)
    @warehouse = warehouse.cl_warehouse_id
    
  end

end