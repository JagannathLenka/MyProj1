class BaysmaintenanceController < ApplicationController
  
   # GET /maintenance
  def index
    @columns =  ['id','sm_bay_id', 'cl_bay_id','client_id','description','sm_aisle_id','cl_aisle_id','aisle_id','sm_zone_id','cl_zone_id','sm_warehouse_id','cl_warehouse_id','no_of_level_bay','attribute1', 'attribute2', 'attribute3', 'attribute4','attribute5','attribute6', 'attribute7','attribute8']
    @bay = Bay.select(" id , sm_bay_id , cl_bay_id , client_id , description , sm_aisle_id , cl_aisle_id , aisle_id , sm_zone_id , cl_zone_id ,sm_warehouse_id , cl_warehouse_id , no_of_level_bay , attribute1 , attribute2 , attribute3 , attribute4 , attribute5 , attribute6 , attribute7 , attribute8 ").where(:aisle_id => params[:id]).paginate(
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

  when "add"
        maximum_bay_add = Bay.maximum("sm_bay_id").to_i + 1
        @bay= Bay.new(:sm_bay_id =>  maximum_bay_add, 
                         cl_bay_id => params[:cl_bay_id],
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
end
    if request.xhr?
      render :json => @bay
    end
 end
 
end
