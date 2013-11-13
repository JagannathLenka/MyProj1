class ZonemaintenanceController < ApplicationController
   # GET /zonemaintenance
 def index

    #Get the header details of the zone
    get_header_details
    
    columns =         ['id','sm_zone_id','cl_zone_id','description','client_id','sm_warehouse_id','cl_warehouse_id',
                        'warehouse_id', 'no_of_aisles_zone', 'no_of_aisles_zone_hidden', 'no_of_bays_aisle','no_of_levels_aisle', 
                        'attribute1', 'attribute2', 'attribute3','attribute4','attribute5','attribute6','attribute7','attribute8']
   
    zone = Zone.select("id , sm_zone_id , cl_zone_id , description , client_id ,sm_warehouse_id , cl_warehouse_id, 
                        warehouse_id , no_of_aisles_zone,no_of_aisles_zone as no_of_aisles_zone_hidden,
                         no_of_bays_aisle, no_of_levels_aisle  , attribute1, attribute2, attribute3 , attribute4 ,
                         attribute5, attribute6, attribute7 , attribute8").where(:warehouse_id => params[:id]).paginate(
    
      :page     => params[:page],
      :per_page => params[:rows],
      :order    => order_by_from_params(params))
   
    
      
    if request.xhr? 
      
      render :json => json_for_jqgrid(zone, columns)
      
    end

  end
  
#POST Edit Zones and Add/Edit ailses 
 def create
   
    @error = ""
    case params[:oper]
  
    when "edit"
      edit_zones_details
         
    when "add"
                
          zone = Zone.find_by_id(params[:id])
          warehouse = Warehouse.find_by_id(params[:pt_warehouse_id].to_i)    
          maximum_zone_id =  Zone.where(:warehouse_id => params[:pt_warehouse_id]).maximum("sm_zone_id").to_i + 1
          zone= Zone.new(:sm_zone_id => maximum_zone_id, 
                                     :sm_warehouse_id => warehouse.sm_warehouse_id,  
                                     :warehouse_id  => warehouse.id,                                   
                                     :cl_zone_id => params[:cl_zone_id],
                                     :cl_warehouse_id => warehouse.cl_warehouse_id,
                                     :description => params[:description],
                                     :no_of_aisles_zone => 0,
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
           @error = params[:cl_zone_id]+ ' ' + zone.errors.values[0][0] if zone.errors.count > 0 
           add_aisles_to_zone zone if zone.errors.count <= 0 
           
  
            when "del"
               zone = Zone.destroy(params[:id].to_i) 
               end   
   
  
      
    if request.xhr?
       if !@error.blank?        
          render :json => @error.to_json, status: 500
       else
          render :json => zone
       end
     end 
  
end

def edit_zones_details
   zone = Zone.find_by_id(params[:id])
   case  
        #add in the number of Aisles
        when params[:no_of_aisles_zone].to_i >  (zone.no_of_aisles_zone.nil? ? 0 : zone.no_of_aisles_zone)
             add_aisles_to_zone zone
             
             
        #delete in the number of Aisles
        when params[:no_of_aisles_zone].to_i <  (zone.no_of_aisles_zone.nil? ? 0 : zone.no_of_aisles_zone)
             remove_aisles_from_zone zone
             

        else
            #update_aisles zone
       end 
        zone.update_attributes({ 
                                     :cl_zone_id => params[:cl_zone_id],
                                     :description => params[:description],
                                     #:no_of_aisles_zone => params[:no_of_aisles_zone],
                                     :attribute1 => params[:attribute1],
                                     :attribute2 => params[:attribute2], 
                                     :attribute3 => params[:attribute3],
                                     :attribute4 => params[:attribute4],
                                     :attribute5 => params[:attribute5],
                                     :attribute6 => params[:attribute6],
                                     :attribute7 => params[:attribute7],
                                     :attribute8 => params[:attribute8]    
            })  
            
        @error = params[:cl_zone_id]+ ' ' + zone.errors.values[0][0] if zone.errors.count > 0
end

def add_aisles_to_zone zone
         max_aisle = Aisle.where(:zone_id => zone.id).maximum("sm_aisle_id").to_i
         newaisle = params[:no_of_aisles_zone].to_i
         existingaisle = zone.no_of_aisles_zone.nil? ? 0 : zone.no_of_aisles_zone
         diff_aislevalue = newaisle - existingaisle
         
           
           (1..diff_aislevalue).each do |a|
            aisles  = Aisle.new(:sm_aisle_id       => max_aisle + a,
                                :attribute1        => "%03d" % (max_aisle + a),
                                :sm_zone_id         => zone.sm_zone_id,
                                :sm_warehouse_id    => zone.sm_warehouse_id,
                                :zone_id            => zone.id,
                                :cl_aisle_id        => "",
                                :cl_zone_id         => zone.cl_zone_id,
                                :cl_warehouse_id    => zone.cl_warehouse_id,
                                :no_of_bays_aisle   => 0,
                              
                          )
             aisles.save
          end
end

def remove_aisles_from_zone zone
         newaisle = params[:no_of_aisles_zone].to_i
         existingaisle = zone.no_of_aisles_zone
         diff_aislevalue = existingaisle -  newaisle 
         
           (1..diff_aislevalue).each do |a|
             Aisle.where(:zone_id => zone.id).last.destroy
            end 
end

        
       
  def get_header_details
    
   warehouse = Warehouse.find_by_id(params[:id])
   add_breadcrumb "Warehouse:" + warehouse.cl_warehouse_id, "/zonemaintenance?id="+ warehouse.id.to_s
   @warehouse = warehouse.cl_warehouse_id
   
  end
  
end