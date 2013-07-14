class AislemaintenanceController < ApplicationController
  
   # GET /maintenance
  def index
 
    @columns =  ['id', 'customer_aisle_id', 'zone_id', 'noof_bays', 'properties1', 'properties2' , 'properties3']
    @aisles = Aisle.where(:zone_id => params[:id]).paginate(
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
                                   :customer_aisle_id => params[:customer_aisle_id],
                                   :zone_id     => params[:zone_id],
                                   :noof_bays => params[:noof_bays],
                                   :properties1 => params[:properties1],
                                   :properties2 => params[:properties2], 
                                   :properties3 => params[:properties3],
                                        
                                  })

  when "add"
        
        @aisles= Aisle.new(:aisle_id => "" , 
                           :customer_aisle_id => params[:customer_aisle_id],
                           :zone_id     => params[:zone_id],
                           :noof_bays => params[:noof_bays],
                           :properties1 => params[:properties1],
                           :properties2 => params[:properties2], 
                           :properties3 => params[:properties3]
                                
                          )
        
         @aisles.save 
         @bayval = params[:noof_bays]
         (1..bayval).each do |bval|
           Bay.create(:bay_id => "",
                             :customer_bay_id => "",
                             :aisle_id => @aisles.id,
                             :noof_pos => "",
                             :properties1 => "",
                             :properties2 => "",
                             :properties3 => "",
                             :row_aisle => "",
           )
         end
                 
end
    if request.xhr?
      render :json => @aisles
    end
 end
 
end
