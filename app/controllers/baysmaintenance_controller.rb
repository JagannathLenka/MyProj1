class BaysmaintenanceController < ApplicationController
  
   # GET /maintenance
  def index

    @columns =  ['id', 'customer_bay_id','aisle_id','noof_pos','row_aisle', 'properties1', 'properties2', 'properties3' ]
    @bay = Bay.where(:aisle_id => params[:id]).paginate(
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
                                   :customer_bay_id => params[:customer_bay_id],
                                   :aisle_id     => params[:aisle_id],
                                   :noof_pos     => params[:noof_pos],
                                   :row_aisle    => params[:row_aisle],
                                   :properties1 => params[:properties1],
                                   :properties2 => params[:properties2], 
                                   :properties3 => params[:properties3]
                                })

  when "add"
        
        @bay= Bay.new(:bay_id => "", 
                         :customer_bay_id => params[:customer_bay_id],
                         :aisle_id     => params[:aisle_id],
                         :noof_pos     => params[:noof_pos],
                         :row_aisle    => params[:row_aisle],
                         :properties1 => params[:properties1],
                         :properties2 => params[:properties2], 
                         :properties3 => params[:properties3]
                         
                       )
        
         @bay.save         
end
    if request.xhr?
      render :json => @bay
    end
 end
 
end
