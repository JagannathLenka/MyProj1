class AislemaintenanceController < ApplicationController
  
   # GET /maintenance
  def index

    @columns =  ['id','sm_aisle_id', 'cl_aisle_id','client_id', 'sm_zone_id','cl_zone_id','zone_id',
                 'sm_warehouse_id' ,'cl_warehouse_id','description', 'no_of_bays_aisle',
                  'attribute1', 'attribute2' , 'attribute3','attribute4',
                  'attribute5','attribute6','attribute7','attribute8']
    @aisles = Aisle.select(" id ,sm_aisle_id , cl_aisle_id ,client_id , sm_zone_id ,cl_zone_id , zone_id ,
                 sm_warehouse_id , cl_warehouse_id,  description ,no_of_bays_aisle ,
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
         
           @bayvalue = params[:no_of_bays_aisle].to_i
            max_bays = Bay.where(:aisle_id => @aisle.id).maximum("sm_bay_id")             
          (1..bayvalue).each do |b|
             @bays = Bay.new(:sm_bay_id           => max_bays.to_i + b,
                             :sm_aisle_id         => @aisles.sm_aisle_id,
                             :sm_zone_id          => @aisles.sm_zone_id,
                             :sm_warehouse_id     => @aisles.sm_warehouse_id,
                             :aisle_id            => @aisles.id,
                             :cl_bay_id           => "",
                             :cl_aisle_id         => @aisles.cl_aisle_id,
                             :cl_zone_id          => @aisles.cl_zone_id,
                             :cl_warehouse_id     => @aisles.cl_warehouse_id,
                             :no_of_level_bay     => params[:no_of_level_bay]
                          )
             @bays.save
         end
                 
end
    if request.xhr?
      render :json => @aisles
    end
 end
 
end
