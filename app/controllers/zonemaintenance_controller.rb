class ZonemaintenanceController < ApplicationController
   # GET /maintenance
  def index

    @columns =  ['id','zone_id','zone_customerid','description', 'noofaisles_zone', 'noofbays_aisle','nooflevel_aisle','warehouse_id', 'properties1', 'properties2', 'properties3']
    @zone = Zone.where(:warehouse_id => params[:id]).paginate(
      :page     => params[:page],
      :per_page => params[:rows],
      :order    => order_by_from_params(params))
  
    if request.xhr?
      
      render :json => json_for_jqgrid(@zone, @columns)
    end

  end

 def create
   
    case params[:oper]
  
    when "edit"
          @zone = Zone.find_by_id(params[:id])
          @zone.update_attributes({ 
                                     :zone_customerid => params[:zone_customerid],
                                     :description => params[:description],
                                     :noofaisles_zone => params[:noofaisles_zone],
                                     :noofbays_aisle => params[:noofbays_aisle],
                                     :nooflevel_aisle => params[:nooflevel_aisle],
                                     :warehouse_id => params[:warehouse_id],
                                     :properties1 => params[:properties1],
                                     :properties2 => params[:properties2], 
                                     :properties3 => params[:properties3],
                                         
            })
           create_aisles_and_bays 
           create_level
    when "add"
          
          @zone= Zone.new(:zone_id => params[:zone_id], 
                             :zone_customerid => params[:zone_customerid],
                             :description => params[:description],
                             :noofaisles_zone => params[:noofaisles_zone],
                             :noofbays_aisle => params[:noofbays_aisle],
                             :nooflevel_aisle => params[:nooflevel_aisle],
                             :warehouse_id => params[:warehouse_id],
                             :properties1 => params[:properties1],
                             :properties2 => params[:properties2], 
                             :properties3 => params[:properties3],
            )
           @zone.save
           create_aisles_and_bays
           create_level
    end
  
      
      if request.xhr?
        render :json => @zone
      end

 end


def create_aisles_and_bays

         aisleval = params[:noofaisles_zone].to_i
         bayval = params[:noofbays_aisle].to_i
         (1..aisleval).each do |a|
            @aval = Aisle.new(:aisle_id => a,
                            :customer_aisle_id => "",
                            :noof_bays => params[:noofbays_aisle],
                            :properties1 => "",
                            :properties2 => "",
                            :properties3 => "",
                            :zone_id => @zone.id
                           )
            @aval.save
          (1..bayval).each do |b|
             @bval = Bay.new(:bay_id => b,
                             :customer_bay_id => "",
                             :aisle_id => @aval.id,
                             :noof_pos => "",
                             :properties1 => "",
                             :properties2 => "",
                             :properties3 => "",
                             :row_aisle => "",
                           )
             @bval.save
          
          
          end
         
         
       end     

  
end

def create_level
  
  levelval = params[:nooflevel_aisle].to_i
  
  (1..levelval).each do |lev|
    @lval = Level.new(:level_id => lev,
                         :zone_id => @zone.id,
                         :level_customerid => "",
                         :properties1 => "",
                         :properties2 => "",
                         :properties3 => "",
                      
                        )
              @lval.save
              
        end
end
 
 
end