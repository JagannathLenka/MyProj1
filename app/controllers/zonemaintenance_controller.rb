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
           #create_aisles_and_bays 
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
           #create_aisles_and_bays
           #create_level
    end
  
      
      if request.xhr?
        render :json => @zone
      end

 end


def create_aisles_and_bays

         aislevalue = params[:noofaisles_zone].to_i
         hidden_aislevalue = params[:noofaisles_zone_hidden].to_i
         bayvalue = params[:noofbays_aisle].to_i
         max_aisle = Aisle.where(:sm_zone_id => params[:id]).maximum("aisle_id")
         
         if(aislevalue > hidden_aislevalue)
           diff_aislevalue = aislevalue - hidden_aislevalue
            (1..diff_aislevalue).each do |a|
            @aval = Aisle.new(:aisle_id => max_aisle.to_i + a,
                            :customer_aisle_id => "",
                            :noof_bays => params[:noofbays_aisle],
                            :properties1 => "",
                            :properties2 => "",
                            :properties3 => "",
                            :sm_zone_id => @zone.id
                           )
             @aval.save
             
          (1..bayval).each do |b|
             @bval = Bay.new(:bay_id => b,
                             :customer_bay_id => "",
                             :aisle_id => @aval.id,
                             :noof_pos => "",
                             :properties1 => "",
                             :properties2 => "",
                             :properties3 => "",
                             :row_aisle => "",
                           )
             @bval.save
             
           end
          
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