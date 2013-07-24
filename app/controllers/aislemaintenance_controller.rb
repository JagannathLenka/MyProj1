class AislemaintenanceController < ApplicationController
  
   # GET /maintenance
  def index

    @columns =  ['id','sm_aisle_id', 'cl_aisle_id','client_id', 'sm_zone_id','cl_zone_id','zone_id',
                 'sm_warehouse_id' ,'cl_warehouse_id','description', 'no_of_bays_aisle', 'no_of_bays_aisle_hidden',
                  'attribute1', 'attribute2' , 'attribute3','attribute4',
                  'attribute5','attribute6','attribute7','attribute8']
    @aisles = Aisle.select(" id ,sm_aisle_id , cl_aisle_id ,client_id , sm_zone_id ,cl_zone_id , zone_id ,
                 sm_warehouse_id , cl_warehouse_id,  description ,no_of_bays_aisle ,no_of_bays_aisle as no_of_bays_aisle_hidden,
                  attribute1 , attribute2  , attribute3 ,attribute4 ,
                  attribute5, attribute6 , attribute7 , attribute8 ").where(:zone_id => params[:id]).paginate(
                   :page     => params[:page],
                   :per_page => params[:rows],
                   :order    => order_by_from_params(params))
  
    if request.xhr?
      render :json => json_for_jqgrid(@aisles, @columns)
    end

  end

 def create
  
  case params[:oper]
  when "edit"
        @aisles = Aisle.find_by_id(params[:id])
        @aisles.update_attributes({ 
                                   :cl_aisle_id => params[:cl_aisle_id],
                                   :description    => params[:description],
                                   :no_of_bays_aisle => params[:no_of_bays_aisle],
                                   :attribute1 => params[:attribute1],
                                   :attribute2 => params[:attribute2], 
                                   :attribute3 => params[:attribute3],
                                   :attribute4 => params[:attribute4],
                                   :attribute5 => params[:attribute5],
                                   :attribute6 => params[:attribute6],
                                   :attribute7 => params[:attribute7],
                                   :attribute8 => params[:attribute8]    
                                  })


          create_bays
          
  when "add"
        maximum_aisle_add = Aisle.maximum("sm_aisle_id").to_i + 1
        @aisles= Aisle.new(:sm_aisle_id => maximum_aisle_add, 
                                   :cl_aisle_id => params[:cl_aisle_id],
                                   :zone_id => params[:zone_id],
                                   :description  => params[:description],
                                   :no_of_bays_aisle => params[:no_of_bays_aisle],
                                   :attribute1 => params[:attribute1],
                                   :attribute2 => params[:attribute2], 
                                   :attribute3 => params[:attribute3],
                                   :attribute4 => params[:attribute4],
                                   :attribute5 => params[:attribute5],
                                   :attribute6 => params[:attribute6],
                                   :attribute7 => params[:attribute7],
                                   :attribute8 => params[:attribute8]   
                                
                          )
        
         @aisles.save 
         create_bays
           
 end        
         

    if request.xhr?
      render :json => @aisles
    end
 end
 
 #Create and save atribute for bays
 def create_bays
   
     max_bays  = Bay.where(:aisle_id => @aisles.id.to_s).maximum("sm_bay_id")
     bayvalue = params[:no_of_bays_aisle].to_i
     hidden_bayvalue = params[:no_of_bays_aisle_hidden].to_i 
     if(bayvalue > hidden_bayvalue)
         diff_bayval =  bayvalue - hidden_bayvalue     
          (1.. diff_bayval).each do |b|
             if params[:attribute3].strip == "LR"
               side_of_aisle =  b <= params[:no_of_bays_aisle].to_i/2? "L" : "R" 
             else
               side_of_aisle = params[:attribute3]
             end  
             @bays = Bay.new(:sm_bay_id           => max_bays.to_i + b,
                             :sm_aisle_id         => @aisles.sm_aisle_id,
                             :sm_zone_id          => @aisles.sm_zone_id,
                             :sm_warehouse_id     => @aisles.sm_warehouse_id,
                             :aisle_id            => @aisles.id,
                             :cl_bay_id           => "",
                             :cl_aisle_id         => @aisles.cl_aisle_id,
                             :cl_zone_id          => @aisles.cl_zone_id,
                             :cl_warehouse_id     => @aisles.cl_warehouse_id,
                             :no_of_level_bay     => params[:no_of_level_bay],
                             :attribute3          => side_of_aisle
                          )
             @bays.save
         end
                 
     end
     
     #When there is no change in aisle value but just change in other parameters
     if(bayvalue = hidden_bayvalue)
             bay_set = Bay.where(:aisle_id => @aisles.id.to_s)
             counter = 0
             bay_set.each do |bays| 
                 counter = counter + 1
                 if params[:attribute3].strip == "LR"
                   side_of_aisle = counter <= params[:no_of_bays_aisle].to_i/2? "L" : "R" 
                 else
                   side_of_aisle = params[:attribute3]
                 end    
    
                  bays.update_attributes({ 
                                      :cl_aisle_id         => @aisles.cl_aisle_id,
                                      :cl_zone_id          => @aisles.cl_zone_id,
                                      :cl_warehouse_id     => @aisles.cl_warehouse_id,
                                      :attribute3          => side_of_aisle
                                      })
              end      
     end         

 
 end

end
