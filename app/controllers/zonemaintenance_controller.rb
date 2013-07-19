class ZonemaintenanceController < ApplicationController
   # GET /zonemaintenance
  def index

    @columns =         ['id','sm_zone_id','cl_zone_id','client_id','sm_warehouse_id','cl_warehouse_id',
                        'warehouse_id','description', 'no_of_aisles_zone', 'no_of_aisles_zone_hidden', 'no_of_bays_aisle','no_of_levels_aisle', 
                         'attribute1', 'attribute2', 'attribute3','attribute4','attribute5','attribute6','attribute7','attribute8']
   
    @zone = Zone.select("id , sm_zone_id , cl_zone_id , client_id ,sm_warehouse_id , cl_warehouse_id, 
                          warehouse_id ,description , no_of_aisles_zone,no_of_aisles_zone as no_of_aisles_zone_hidden,  no_of_bays_aisle, no_of_levels_aisle  ,
                          attribute1, attribute2, attribute3 , attribute4 , attribute5, attribute6, attribute7 , attribute8").where(:warehouse_id => params[:id]).paginate(
    
      :page     => params[:page],
      :per_page => params[:rows],
      :order    => order_by_from_params(params))
  
    if request.xhr? 
      
      render :json => json_for_jqgrid(@zone, @columns)
    end

  end
  
  #POST /zonemaintenance - Create aisle
 def create
   
    case params[:oper]
  
    when "edit"
          @zone = Zone.find_by_id(params[:id])
          @zone.update_attributes({ 
                                     :cl_zone_id => params[:cl_zone_id],
                                     :description => params[:description],
                                     :no_of_aisles_zone => params[:no_of_aisles_zone],
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
           create_aisles_and_bays 
           #create_level
           
    when "add"
          maximum_zone_id =  Zone.maximum("sm_zone_id").to_i + 1
          @zone= Zone.new(           :sm_zone_id => maximum_zone_id, 
                                     :sm_warehouse_id => params[:sm_warehouse_id], #This is not correct
                                     :warehouse_id  => params[:warehouse_id],      #This is not correct                                
                                     :cl_zone_id => params[:cl_zone_id],
                                     :description => params[:description],
                                     :no_of_aisles_zone => params[:no_of_aisles_zone],
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

            )
           @zone.save
           create_aisles_and_bays
           #create_level
    end
  
      
      if request.xhr?
        render :json => @zone
      end

 end


def create_aisles_and_bays

         aislevalue = params[:no_of_aisles_zone].to_i
         hidden_aislevalue = params[:no_of_aisles_zone_hidden].to_i
         bayvalue = params[:no_of_bays_aisle].to_i
         max_aisle = Aisle.where(:zone_id => params[:id]).maximum("sm_aisle_id")
         
           diff_aislevalue = aislevalue - hidden_aislevalue
           (1..diff_aislevalue).each do |a|
           @aisle  = Aisle.new(:sm_aisle_id      => max_aisle.to_i + a,
                              :sm_zone_id         => params[:sm_zone_id],
                              :sm_warehouse_id    => params[:sm_warehouse_id],
                              :zone_id            => @zone.id,
                              :no_of_bays_aisle   => params[:no_of_bays_aisle],
                              :cl_aisle_id        => "",
                              :cl_zone_id         => params[:cl_zone_id],
                              :cl_warehouse_id    => @zone.cl_warehouse_id
                          )
             @aisle.save

          max_bays = Bay.where(:aisle_id => @aisle.id).maximum("sm_bay_id")             
          (1..bayvalue).each do |b|
             @bays = Bay.new(:sm_bay_id           => max_bays.to_i + b,
                             :sm_aisle_id         => @aisle.sm_aisle_id,
                             :sm_zone_id          => @aisle.sm_zone_id,
                             :sm_warehouse_id     => @aisle.sm_warehouse_id,
                             :aisle_id            => @aisle.id,
                             :cl_bay_id           => "",
                             :cl_aisle_id         => @aisle.cl_aisle_id,
                             :cl_zone_id          => @aisle.cl_warehouse_id,
                             :no_of_level_bay     => params[:no_of_level_bay]
                          )
             @bays.save
             
           end
          
     end
  
      
end

 def create_level
  
  levelval = params[:nooflevel_aisle].to_i
  
  (1..levelval).each do |lev|
    @lval = Level.new(:level_id => lev,
                         :sm_zone_id => @zone.id,
                         :level_customerid => "",
                         :properties1 => "",
                         :properties2 => "",
                         :properties3 => "",
                      
                        )
              @lval.save
              
        end

 
 
   end

end