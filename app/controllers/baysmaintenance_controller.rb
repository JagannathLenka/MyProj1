require 'copy_object'
class BaysmaintenanceController < ApplicationController
  
  include CopyObject
   # GET /Render the JQGrid for bay maintenance
  def index
     if params[:lightweight] != "yes"  
      get_header_details
    end
    columns =  ['id','sm_bay_id', 'cl_bay_id','description','client_id','sm_aisle_id','cl_aisle_id',
                'aisle_id','sm_zone_id','cl_zone_id','sm_warehouse_id','cl_warehouse_id','no_of_level_bay',
                'no_of_level_bay_hidden','attribute1', 'attribute2', 'attribute3', 'attribute4','attribute5',
                'attribute6', 'attribute7','attribute8']
      
    bays = Bay.select(" id , sm_bay_id , cl_bay_id ,description, client_id , sm_aisle_id ,
                       cl_aisle_id , aisle_id , sm_zone_id , cl_zone_id ,sm_warehouse_id , 
                       cl_warehouse_id , no_of_level_bay , no_of_level_bay as no_of_level_bay_hidden,
                       attribute1 , attribute2 , attribute3 , attribute4 , attribute5 , attribute6 ,
                        attribute7 , attribute8 ").where(:aisle_id => params[:id]).paginate(
                                                         :page     => params[:page],
                                                         :per_page => params[:rows],
                                                         :order    => order_by_from_params(params))
  
    if request.xhr?
      render :json => json_for_jqgrid(bays, columns)
    end
    
     
end

#Update the bays and create bays and levels beased on the input from JQgrid
 def create
   
  case params[:oper]
  when "edit"
        edit_bays_details
       
  when "add"
    
        bays = Bay.find_by_id(params[:id])
        aisles = Aisle.find_by_id(params[:pt_aisle_id].to_i)
        maximum_bay_id = Bay.where(:aisle_id => params[:pt_aisle_id]).maximum("sm_bay_id").to_i + 1
        bays= Bay.new(:sm_bay_id =>  maximum_bay_id, 
                         :cl_bay_id => params[:cl_bay_id],
                         :sm_aisle_id => aisles.sm_aisle_id,
                         :cl_aisle_id => aisles.cl_aisle_id,
                         :sm_zone_id => aisles.sm_zone_id,
                         :cl_zone_id => aisles.cl_zone_id,
                         :sm_warehouse_id => aisles.sm_warehouse_id,
                         :cl_warehouse_id => aisles.cl_warehouse_id,
                         :aisle_id     => aisles.id,
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
               add_levels_to_bay bays
               
               aisles.update_attributes({
                                         :no_of_bays_aisle => aisles.no_of_bays_aisle + 1
               })
                
               
    when "del"
         bays = Bay.destroy(params[:id].to_i) 
       
    when "cpy"
             
             CopyObject.copyBaytoAisle params[:id]
              
    end   
   
         

    if request.xhr?
      render :json => bays
    end
 end
 
 def edit_bays_details
     bays = Bay.find_by_id(params[:id].to_i)
    
     case 
        
        #add in the number of levels
        when params[:no_of_level_bay].to_i >  (bays.no_of_level_bay.nil? ? 0 :   bays.no_of_level_bay)
             add_levels_to_bay bays
             
             
        #delete in the number of levels
        when params[:no_of_level_bay].to_i < (bays.no_of_level_bay.nil? ? 0 :   bays.no_of_level_bay)
             remove_levels_from_bay bays

       end   
    
      bays.update_attributes({ 
                                   :cl_bay_id => params[:cl_bay_id],
                                   :description => params[:description],
                                   :no_of_level_bay  => params[:no_of_level_bay],
                                   :attribute1 => params[:attribute1],
                                   :attribute2 => params[:attribute2], 
                                   #:attribute3 => params[:attribute3],
                                   :attribute4 => params[:attribute4],
                                   :attribute5 => params[:attribute5],
                                   :attribute6 => params[:attribute6],
                                   :attribute7 => params[:attribute7],
                                   :attribute8 => params[:attribute8]    
                                })

 end
 
 def add_levels_to_bay bays
         max_levels = Level.where(:bay_id => bays.id).maximum("sm_level_id").to_i  
         newlevel = params[:no_of_level_bay ].to_i
         existinglevel = bays.no_of_level_bay.nil? ? 0 : bays.no_of_level_bay
         diff_levelvalue = newlevel - existinglevel
         
                 
            (1..diff_levelvalue).each do |lev|
               levels = Level.new(:sm_level_id     => max_levels + lev,
                               :sm_bay_id           => bays.sm_bay_id,
                               :sm_aisle_id         => bays.sm_aisle_id,
                               :sm_zone_id          => bays.sm_zone_id,
                               :sm_warehouse_id     => bays.sm_warehouse_id,
                               :bay_id              => bays.id,
                               :cl_level_id         => "",
                               :cl_bay_id           => bays.cl_bay_id,
                               :cl_aisle_id         => bays.cl_aisle_id,
                               :cl_zone_id          => bays.cl_zone_id,
                               :cl_warehouse_id     => bays.cl_warehouse_id,
                               :no_of_pos_level    => 0,
                            )
               levels.save
            end  
 end

 def remove_levels_from_bay bays
   
         newlevel = params[:no_of_level_bay ].to_i
         existinglevel = bays.no_of_level_bay
         diff_levelvalue = existinglevel - newlevel
         
           (1..diff_levelvalue).each do |lev|
             Level.where(:bay_id => bays.id).last.destroy
            end
 end
 
 
 def get_header_details
   if cookies[:userid].nil? 
               redirect_to "/login"
    else
      @userid = cookies[:userid]
    end
   aisle = Aisle.find_by_id(params["id"].to_i)
   zone  = Zone.find_by_id(aisle.zone_id)
   warehouse = Warehouse.find_by_id(zone.warehouse_id)

   add_breadcrumb "Warehouse:" + warehouse.cl_warehouse_id, "/zonemaintenance?id="+ warehouse.id.to_s
   add_breadcrumb "Zone:" + (zone.cl_zone_id.blank? ? zone.sm_zone_id.to_s : zone.cl_zone_id.to_s), "/aislemaintenance?id="+ zone.id.to_s
   add_breadcrumb "Aisle:" + (aisle.cl_aisle_id.blank? ?aisle.sm_aisle_id.to_s: aisle.cl_aisle_id), "/baysmaintenance?id="+ aisle.id.to_s 
   @warehouse = warehouse.cl_warehouse_id 
end 
end
