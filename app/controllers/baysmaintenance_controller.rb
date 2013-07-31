class BaysmaintenanceController < ApplicationController
  
   # GET /maintenance
  def index
    columns =  ['id','sm_bay_id', 'cl_bay_id','client_id','description','sm_aisle_id','cl_aisle_id','aisle_id','sm_zone_id','cl_zone_id','sm_warehouse_id','cl_warehouse_id','no_of_level_bay','no_of_level_bay_hidden','attribute1', 'attribute2', 'attribute3', 'attribute4','attribute5','attribute6', 'attribute7','attribute8']
    bay = Bay.select(" id , sm_bay_id , cl_bay_id , client_id , description , sm_aisle_id , cl_aisle_id , aisle_id , sm_zone_id , cl_zone_id ,sm_warehouse_id , cl_warehouse_id , no_of_level_bay , no_of_level_bay as no_of_level_bay_hidden, attribute1 , attribute2 , attribute3 , attribute4 , attribute5 , attribute6 , attribute7 , attribute8 ").where(:aisle_id => params[:id]).paginate(
      :page     => params[:page],
      :per_page => params[:rows],
      :order    => order_by_from_params(params))
  
    if request.xhr?
      #@invoices = 'ok'
      render :json => json_for_jqgrid(bay, columns)
    end

  end

 def create
   
  case params[:oper]
  when "edit"
        bays = Bay.find_by_id(params[:id])
        bays.update_attributes({ 
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
                                
                  create_level  bays            

  when "add"
        maximum_bay_add = Bay.maximum("sm_bay_id").to_i + 1
        bays= Bay.new(:sm_bay_id =>  maximum_bay_add, 
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
        
         bays.save 
         create_level bays
         
end
    if request.xhr?
      render :json => bays
    end
 end
 
 def create_level bays
         levelvalue = params[:no_of_level_bay ].to_i
         hidden_levelvalue = params[:no_of_level_bay_hidden].to_i
         diff_levelvalue = levelvalue - hidden_levelvalue
         max_levels = Level.where(:bay_id => id).maximum("sm_level_id").to_i  
         if( levelvalue >  hidden_levelvalue)          
            (1..diff_levelvalue).each do |lev|
               @levels = Level.new(:sm_level_id     => max_levels + lev,
                               :sm_bay_id           => bays.sm_bay_id,
                               :sm_aisle_id         => bays.sm_aisle_id,
                               :sm_zone_id          => bays.sm_zone_id,
                               :sm_warehouse_id     => bays.sm_warehouse_id,
                               :bay_id              => bays.id,
                               :cl_level_id         => "",
                               :cl_bay_id           => bays.cl_bay_id,
                               :cl_aisle_id         => bays.cl_aisle_id,
                               :cl_zone_id          => bayss.cl_zone_id,
                               :cl_warehouse_id     => bays.cl_warehouse_id,
                               :no_of_pos_level    => params[:no_of_pos_level]
                            )
               @levels.save
            end  
         
        else 
         #When there is no change in level value but just change in other parameters
        
            level_set = Level.where(:bay_id => bays.id.to_s)
            level_set.each do |levels| 
                  levels.update_attributes({ 
                                  :cl_bay_id         =>bays.cl_bay_id, 
                                  :cl_aisle_id       =>bays.cl_aisle_id,
                                  :cl_zone_id         =>bays.cl_zone_id,
                                  :cl_warehouse_id    =>bays.cl_warehouse_id
                                  })
                  end      
          end  
 end
end
