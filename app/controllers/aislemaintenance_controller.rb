require 'copy_object'
class AislemaintenanceController < ApplicationController
  
 include CopyObject
  
 # GET /Render the JQGrid for aisle maintenance
  def index
    
      if params["aisleid"].blank?
          #Get the header details of the zone
          get_header_details
      end
      

     columns =  ['id','sm_aisle_id', 'cl_aisle_id','description','client_id', 'sm_zone_id','cl_zone_id','zone_id',
                  'sm_warehouse_id' ,'cl_warehouse_id', 'no_of_bays_aisle', 'no_of_bays_aisle_hidden','no_of_levels_aisle','no_of_levels_aisle_hidden',
                  'attribute3','attribute4', 'attribute1', 'attribute2' , 
                  'attribute5','attribute6','attribute7','attribute8']
                  
     selectParam = params["aisleid"].blank? ? {:zone_id => params[:id]} : {:id => params["aisleid"].to_i}


     aisles = Aisle.select(" id ,sm_aisle_id , cl_aisle_id , description ,client_id , sm_zone_id ,cl_zone_id , zone_id ,
                    sm_warehouse_id , cl_warehouse_id,no_of_bays_aisle ,no_of_bays_aisle as no_of_bays_aisle_hidden,no_of_levels_aisle,no_of_levels_aisle as no_of_levels_aisle_hidden,
                    attribute3 , attribute4 , attribute1 , attribute2 ,
                    attribute5, attribute6 , attribute7 , attribute8 ").where(selectParam).paginate(
                     :page     => params[:page],
                     :per_page => params[:rows],
                     :order    => order_by_from_params(params))

      
      
     if request.xhr? and params[:lightweight] != "yes"
       render :json => json_for_jqgrid(aisles, columns)
     end

  end

 
 #Update the aisles and create bays and levels beased on the input from JQgrid
 def create
  
  @error = ""
  case params[:oper]
  when "edit"
       edit_aisle_details 
                
  when "add"
        aisles = Aisle.find_by_id(params[:id])
        zone = Zone.find_by_id(params[:pt_zone_id].to_i)
        maximum_aisle_id = Aisle.where(:zone_id => params[:pt_zone_id]).maximum("sm_aisle_id").to_i + 1
        aisles= Aisle.new(:sm_aisle_id => maximum_aisle_id, 
                                   :cl_aisle_id => params[:cl_aisle_id],
                                   :sm_zone_id => zone.sm_zone_id,
                                   :cl_zone_id => zone.cl_zone_id,
                                   :sm_warehouse_id => zone.sm_warehouse_id,
                                   :cl_warehouse_id => zone.cl_warehouse_id,
                                   :zone_id => zone.id,
                                   :description  => params[:description],
                                   :no_of_bays_aisle => 0,
                                   :no_of_levels_aisle => params[:no_of_levels_aisle],
                                   :attribute1 => params[:attribute1],
                                   :attribute2 => params[:attribute2], 
                                   :attribute3 => params[:attribute3],
                                   :attribute4 => params[:attribute4],
                                   :attribute5 => params[:attribute5],
                                   :attribute6 => params[:attribute6],
                                   :attribute7 => params[:attribute7],
                                   :attribute8 => params[:attribute8]   
                          )
        
         aisles.save 
         @error = params[:cl_aisle_id]+ ' ' + aisles.errors.values[0][0] if aisles.errors.count > 0 
         add_bays_to_aisle aisles if aisles.errors.count <= 0 
         
  when "del"
              Aisle.destroy(params[:id].to_i)   
              
  when "cpy"
             
              CopyObject.copyAisletoZone params[:id]
           
 end        
    #If it is a Ajax then send the json details
    
    if request.xhr?
       if !@error.blank?        
        render :json => @error.to_json, status: 500
       else
      render :json => aisles
    end
   end 
 end
 
 
 def edit_aisle_details
 
        aisles = Aisle.find_by_id(params[:id].to_i)
        
        case 
        
        #add in the number of bays
        when params[:no_of_bays_aisle].to_i >  (aisles.no_of_bays_aisle.nil? ? 0 :   aisles.no_of_bays_aisle)
             add_bays_to_aisle aisles
             
             
        #delete in the number of bays
        when params[:no_of_bays_aisle].to_i <  (aisles.no_of_bays_aisle.nil? ? 0 :   aisles.no_of_bays_aisle)
             remove_bays_from_aisle aisles
             

        #update in the row of the bay
        when params[:attribute3] != aisles.attribute3
             update_bays_row aisles

        else
            update_bays aisles
       
       end   
          
       aisles.update_attributes({ 
                                   :cl_aisle_id => params[:cl_aisle_id],
                                   :description    => params[:description],
                                   #:no_of_bays_aisle => params[:no_of_bays_aisle],
                                   :no_of_levels_aisle => params[:no_of_levels_aisle],
                                   :attribute1 => params[:attribute1],
                                   :attribute2 => params[:attribute2], 
                                   :attribute3 => params[:attribute3],
                                   :attribute4 => params[:attribute4],
                                   :attribute5 => params[:attribute5],
                                   :attribute6 => params[:attribute6],
                                   :attribute7 => params[:attribute7],
                                   :attribute8 => params[:attribute8]    
                                  })
                                  
       @error = params[:cl_aisle_id]+ ' ' + aisles.errors.values[0][0] if aisles.errors.count > 0                            

 end
  
 #Create and save atribute for bays
 def add_bays_to_aisle aisles
   
     
     max_bays  = Bay.where(:aisle_id => aisles.id).maximum("sm_bay_id").to_i

     newBay  = params[:no_of_bays_aisle].to_i
     existingBay = aisles.no_of_bays_aisle.nil? ? 0 : aisles.no_of_bays_aisle
     diff_bayval = newBay - existingBay
     
         (1.. diff_bayval).each do |b|
             bays = Bay.new(:sm_bay_id            => max_bays + b,
                             :sm_aisle_id         => aisles.sm_aisle_id,
                             :sm_zone_id          => aisles.sm_zone_id,
                             :sm_warehouse_id     => aisles.sm_warehouse_id,
                             :aisle_id            => aisles.id,
                             :cl_bay_id           => "",
                             :cl_aisle_id         => params[:cl_aisle_id],
                             :cl_zone_id          => aisles.cl_zone_id,
                             :cl_warehouse_id     => aisles.cl_warehouse_id,
                             :no_of_level_bay     => 0,
                          )
             bays.save
       end
       update_bays aisles
       update_bays_row aisles
 end


 #remove bays from aisles
 def remove_bays_from_aisle aisles
   
    
     newBay  = params[:no_of_bays_aisle].to_i
     existingBay = aisles.no_of_bays_aisle 
     diff_bayval = existingBay - newBay 

         (1.. diff_bayval).each do |b|
           Bay.where(:aisle_id => aisles.id).last.destroy
       end
       update_bays aisles
       update_bays_row aisles
 end

 def update_bays_row aisles

       #When there is no change in aisle value but just change in other parameters
             bay_set = Bay.where(:aisle_id => aisles.id).order('sm_bay_id')
             counter = 0
             bay_set.each do |bays| 
                 counter = counter + 1
                 
                 #Change in Sides of aisles
                 if params[:attribute3].strip == "LR"
                   side_of_aisle = counter <= params[:no_of_bays_aisle].to_i/2? "L" : "R" 
                 else
                   side_of_aisle = params[:attribute3]
                 end    
                     
                 bays.update_attributes({ 
                                      :attribute3          => side_of_aisle,
                                      })
             end
 end

 def update_bays aisles

       #When there is no change in aisle value but just change in other parameters
             bay_set = Bay.where(:aisle_id => aisles.id)
             bay_set.each do |bays| 
    
                 case
                   
                 #if there is a add in number of level of bay   
                 when  params[:no_of_levels_aisle].to_i > (bays.no_of_level_bay.nil? ? 0 : bays.no_of_level_bay)
                   add_levels_to_bay bays
                   
                 #if there is a delete in number of level of bay   
                 when  params[:no_of_levels_aisle].to_i < (bays.no_of_level_bay.nil? ? 0 : bays.no_of_level_bay)
                   remove_levels_from_bay bays 
                 end  
                  
                 bays.update_attributes({ 
                                      :no_of_level_bay     => params[:no_of_levels_aisle]
                                      })
             end
 end


 #add levels for each bays
 def add_levels_to_bay bay
   
   max_levels  = Level.where(:bay_id => bay.id).maximum("sm_level_id").to_i

   levelvalue = params[:no_of_levels_aisle].to_i
   existingLevel = bay.no_of_level_bay.nil? ? 0 : bay.no_of_level_bay
   

      diff_levelvalue = levelvalue - existingLevel
      (1..diff_levelvalue).each do |lev|
                  levels = Level.new(
                             :sm_level_id     => max_levels + lev,
                             :sm_bay_id           => bay.sm_bay_id,
                             :sm_aisle_id         => bay.sm_aisle_id,
                             :sm_zone_id          => bay.sm_zone_id,
                             :sm_warehouse_id     => bay.sm_warehouse_id,
                             :bay_id              => bay.id,
                             :cl_level_id         => "",
                             :cl_bay_id           => bay.cl_bay_id,
                             :cl_aisle_id         => bay.cl_aisle_id,
                             :cl_zone_id          => bay.cl_zone_id,
                             :cl_warehouse_id     => bay.cl_warehouse_id,
                             :no_of_pos_level     => ""
                          )
                 levels.save
      end
 end

 #Remove level from bay
 def remove_levels_from_bay bay
   
    
     levelvalue = params[:no_of_levels_aisle].to_i
     existingLevel = bay.no_of_level_bay.nil? ? 0 : bay.no_of_level_bay


     diff_bayval = existingLevel - levelvalue 

         (1.. diff_bayval).each do |b|
           Level.where(:bay_id => bay.id).last.destroy
       end
       
 end
 

 #Write the breadcrumbs
 def get_header_details
   
   zone  = Zone.find_by_id(params["id"].to_i)
   warehouse = Warehouse.find_by_id(zone.warehouse_id)
   @warehouse = warehouse.cl_warehouse_id

   add_breadcrumb warehouse.cl_warehouse_id, "/zonemaintenance?id="+ warehouse.id.to_s
   add_breadcrumb zone.cl_zone_id.blank? ? zone.sm_zone_id: zone.cl_zone_id, "/aislemaintenance?id="+ zone.id.to_s
end 
    
 
end
