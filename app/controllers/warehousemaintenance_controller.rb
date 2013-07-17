class WarehousemaintenanceController < ApplicationController
   # GET /maintenance
  def index

    @columns =  ['id', 'warehouse_customerid','description', 'noof_zones', 'properties1', 'properties2' , 'properties3' ]
    @warehouse = Warehouse.paginate(
      :page     => params[:page],
      :per_page => params[:rows],
      :order    => order_by_from_params(params))
  
    if request.xhr?
      #@invoices = 'ok'
      render :json => json_for_jqgrid(@warehouse, @columns)
    end

  end

 def create
   
  case params[:oper]
  when "edit"
        @warehouse = Warehouse.find_by_id(params[:id])
        @warehouse.update_attributes({
                                   :warehouse_customerid => params[:warehouse_customerid], 
                                   :description => params[:description],
                                   :properties1 => params[:properties1],
                                   :properties2 => params[:properties2], 
                                   :properties3 => params[:properties3],
                                   :noof_zones  => params[:noof_zones]     
          })

  when "add"
        
        @warehouse= Warehouse.new(:warehouse_id => "", 
                                    :warehouse_customerid => params[:warehouse_customerid],
                                   :description => params[:description],
                                   :properties1 => params[:properties1],
                                   :properties2 => params[:properties2], 
                                   :properties3 => params[:properties3],
                                   :noof_zones  => params[:noof_zones]   
          )
        
         @warehouse.save 
         
         zoneval = params[:noof_zones].to_i
         (1..zoneval).each do |z| 
         
                     Zone.create(:zone_id => z,
                                 :zone_customerid => "",
                                 :description => "",
                                 :noofaisles_zone => "",
                                 :noofbays_aisle => "",
                                 :properties1 => "",
                                 :properties2 => "",
                                 :properties3 => "",
                                 :warehouse_id => @warehouse.id 
                               
                               )
                           end 
                               
end
    if request.xhr?
      render :json => @warehouse
    end
 end
end
