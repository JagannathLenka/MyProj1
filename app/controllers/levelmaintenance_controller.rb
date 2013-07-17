class LevelmaintenanceController < ApplicationController
    # GET /maintenance
  def index

    @columns =  ['id','level_id','zone_id','level_customerid','properties1', 'properties2', 'properties3']
    @level = Level.where(:zone_id => params[:id]).paginate(
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
                                     :zone_id => params[:zone_id],
                                     :level_customerid => params[:level_customerid],
                                     :properties1 => params[:properties1],
                                     :properties2 => params[:properties2], 
                                     :properties3 => params[:properties3],
                                         
            })
    when "add"
          
                @level= Level.create(:level_id => params[:level_id], 
                                     :zone_id => params[:zone_id],
                                     :level_customerid => params[:level_customerid],
                                     :properties1 => params[:properties1],
                                     :properties2 => params[:properties2], 
                                     :properties3 => params[:properties3],
                                    )
           
    end
  
      
      if request.xhr?
        render :json => @level
      end

 end

end
