class LevelmaintenanceController < ApplicationController
    # GET /maintenance
  def index
    @columns =  ['id','sm_level_id','cl_level_id','client_id','description', 'sm_bay_id','cl_bay_id','bay_id','no_of_pos_level','no_of_pos_level_hidden', 'sm_aisle_id','cl_aisle_id','sm_zone_id','cl_zone_id','sm_warehouse_id','cl_warehouse_id','attribute1', 'attribute2', 'attribute3', 'attribute4','attribute5','attribute6', 'attribute7','attribute8']
    @level = Level.select(" id , sm_level_id ,cl_level_id ,client_id ,description , sm_bay_id , cl_bay_id , bay_id , no_of_pos_level ,no_of_pos_level as no_of_pos_level_hidden, sm_aisle_id , cl_aisle_id , sm_zone_id , cl_zone_id , sm_warehouse_id , cl_warehouse_id,attribute1 , attribute2 , attribute3 , attribute4 , attribute5 , attribute6 , attribute7 , attribute8 ").where(:bay_id => params[:id]).paginate(
      :page     => params[:page],
      :per_page => params[:rows],
      :order    => order_by_from_params(params))
  
    if request.xhr?
      
      render :json => json_for_jqgrid(@level, @columns)
    end

  end

 def create
   
    case params[:oper]
  
    when "edit"
          @level = Level.find_by_id(params[:id])
          @level.update_attributes({                                   
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
    when "add"
                 maximum_level_add = Level.maximum("sm_level_id").to_i + 1
                @level= Level.create(:sm_level_id => maximum_level_add,
                                     :description => params[:description],
                                     :bay_id    => params[:bay_id],
                                     :no_of_pos_level => params[:no_of_pos_level],
                                     :cl_level_id=> params[:cl_level_id],
                                     :attribute1 => params[:attribute1],
                                     :attribute2 => params[:attribute2], 
                                     :attribute3 => params[:attribute3],
                                     :attribute4 => params[:attribute4],
                                     :attribute5 => params[:attribute5],
                                     :attribute6 => params[:attribute6],
                                     :attribute7 => params[:attribute7],
                                     :attribute8 => params[:attribute8] 
                )   
           
    end
  
      
      if request.xhr?
        render :json => @level
      end

 end

end
