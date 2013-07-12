class BaysmaintenanceController < ApplicationController
  
   # GET /maintenance
  def show

    #@columns = ['invid', 'invdate', 'amount', 'tax', 'total', 'note']
    
    @columns =  ['id', 'bay_id','customer_bay_id', 'properties1','properties2','properties3', 'aisle_id']
    @bays = Bay.paginate(
      :page     => params[:page],
      :per_page => params[:rows],
      :order    => order_by_from_params(params))
  
    if request.xhr?
      #@invoices = 'ok'
      render :json => json_for_jqgrid(@bays, @columns)
    end

  end

 def create
   
  case params[:oper]
  when "edit"
        @aisles = Aisle.find_by_id(params[:id])
        @aisles.update_attributes({:aisle_id => params[:aisle_id], 
                                   :customer_aisle_id => params[:customer_aisle_id],
                                   :properties1 => params[:properties1],
                                   :properties1 => params[:properties1],
                                   :properties2 => params[:properties2], 
                                   :properties3 => params[:properties3],
                                   :zone_id     => params[:zone_id]     
          })

  when "add"
        
        @aisles= Aisle.new(:aisle_id => params[:aisle_id], 
                                   :customer_aisle_id => params[:customer_aisle_id],
                                   :properties1 => params[:properties1],
                                   :properties1 => params[:properties1],
                                   :properties2 => params[:properties2], 
                                   :properties3 => params[:properties3],
                                   :zone_id     => params[:zone_id]     
          )
        
         @aisles.save         
end
    if request.xhr?
      render :json => @aisles
    end
 end
 
end
