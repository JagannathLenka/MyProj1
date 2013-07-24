class BaysmaintenanceController < ApplicationController
  
   # GET /maintenance
  def index
    @columns =  ['id','sm_bay_id', 'cl_bay_id','client_id','description','sm_aisle_id','cl_aisle_id','aisle_id','sm_zone_id','cl_zone_id','sm_warehouse_id','cl_warehouse_id','no_of_level_bay','no_of_level_bay_hidden','attribute1', 'attribute2', 'attribute3', 'attribute4','attribute5','attribute6', 'attribute7','attribute8']
    @bay = Bay.select(" id , sm_bay_id , cl_bay_id , client_id , description , sm_aisle_id , cl_aisle_id , aisle_id , sm_zone_id , cl_zone_id ,sm_warehouse_id , cl_warehouse_id , no_of_level_bay , no_of_level_bay as no_of_level_bay_hidden, attribute1 , attribute2 , attribute3 , attribute4 , attribute5 , attribute6 , attribute7 , attribute8 ").where(:aisle_id => params[:id]).paginate(
      :page     => params[:page],
      :per_page => params[:rows],
      :order    => order_by_from_params(params))
  
    if request.xhr?
      #@invoices = 'ok'
      render :json => json_for_jqgrid(@bay, @columns)
    end

  end

 def create
   
  case params[:oper]
  when "edit"
        @bay = Bay.find_by_id(params[:id])
        @bay.update_attributes({ 
                                   :cl_bay_id => params[:cl_bay_id],
                                   :description => params[:description],
                                   :no_of_level_bay  => params[:no_of_level_bay],
                                   :attribute1 => params[:attribute1],
                                   :attribute2 => params[:attribute2], 
                                   :attribute3 => params[:attribute3],
                                   :attribute4 => params[:attribute4],
                                   :attribute5 => params[:attribute5],
                                   :attribute6 => params[:attribute6],
                                   :attribute7 => params[:attribute7],
                                   :attribute8 => params[:attribute8]    
                                })
                                
                  create_level              

  when "add"
        maximum_bay_add = Bay.maximum("sm_bay_id").to_i + 1
        @bay= Bay.new(:sm_bay_id =>  maximum_bay_add, 
                         :cl_bay_id => params[:cl_bay_id],
                         :aisle_id     => params[:aisle_id],
                         :description  => params[:description],
                         :no_of_level_bay  => params[:no_of_level_bay],
                         :attribute1 => params[:attribute1],
                         :attribute2 => params[:attribute2], 
                         :attribute3 => params[:attribute3],
                         :attribute4 => params[:attribute4],
                         :attribute5 => params[:attribute5],
                         :attribute6 => params[:attribute6],
                         :attribute7 => params[:attribute7],
                         :attribute8 => params[:attribute8]    
                         
                       )
        
         @bay.save 
         create_level
         
end
    if request.xhr?
      render :json => @bay
    end
 end
 
 def create_level
   levelvalue = params[:no_of_level_bay ].to_i
   hidden_levelvalue = params[:no_of_level_bay_hidden].to_i
         max_levels = Level.where(:bay_id => @bay.id).maximum("sm_bay_id")             
          (1..levelvalue).each do |lev|
             @levels = Level.new(:sm_level_id     => max_levels.to_i + lev,
                             :sm_bay_id           => @bay.sm_bay_id,
                             :sm_aisle_id         => @bay.sm_aisle_id,
                             :sm_zone_id          => @bay.sm_zone_id,
                             :sm_warehouse_id     => @bay.sm_warehouse_id,
                             :bay_id              => @bay.id,
                             :cl_level_id         => "",
                             :cl_bay_id           => @bay.cl_bay_id,
                             :cl_aisle_id         => @bay.cl_aisle_id,
                             :cl_zone_id          => @bay.cl_zone_id,
                             :cl_warehouse_id     => @bay.cl_warehouse_id,
                             :no_of_pos_level    => params[:no_of_pos_level]
                          )
             @levels.save
         end  
         
         #When there is no change in level value but just change in other parameters
        if( levelvalue =  hidden_levelvalue)
            level_set = Level.where(:bay_id => @bay.id.to_s)
             level_set.each do |levels| 
                  levels.update_attributes({ 
                                  :cl_bay_id         =>@bay.cl_bay_id, 
                                  :cl_aisle_id       =>@bay.cl_aisle_id,
                                  :cl_zone_id         =>@bay.cl_zone_id,
                                  :cl_warehouse_id    =>@bay.cl_warehouse_id
                                  })
                  end      
        end               
 end
end
