require 'csv'
class LocationmaintenanceController < ApplicationController
  # GET /maintenance
  
  def index
    get_header_details  if !request.xhr?
    warehouse = Warehouse.find(params[:warehouse_id])
    @warehouse = warehouse.cl_warehouse_id
    
    search_string = '1 = 1'
    if params[:_search] == "true"
      case params[:searchOper]
      when 'eq'
        search_string = params[:searchField] + " = '" +  params[:searchString] + "'"
        logger.debug search_string
      when 'bw'
        search_string = params[:searchField] + " like '" +  params[:searchString] + "%'"
        logger.debug search_string
      end 
    end
    
    
    columns =  ['id','sm_loc_id','cl_loc_id','sm_pos_id','cl_pos_id','sm_level_id','cl_level_id','sm_bay_id', 'cl_bay_id','sm_aisle_id','cl_aisle_id','sm_zone_id','cl_zone_id','sm_warehouse_id','cl_warehouse_id','sm_barcode','cl_barcode','client_id','current_item', 'current_quantity','life_time_total_picks', 'lock_code', 'maximum_quantity', 'minimum_quantity','status','attribute1', 'attribute2', 'attribute3', 'attribute4','attribute5','attribute6', 'attribute7','attribute8']
    loc = Location.select("id , sm_loc_id , cl_loc_id , sm_pos_id , cl_pos_id , sm_level_id , cl_level_id , sm_bay_id , cl_bay_id , sm_aisle_id , cl_aisle_id , sm_zone_id , cl_zone_id , sm_warehouse_id , cl_warehouse_id , sm_barcode , cl_barcode , client_id , 
                            current_item , current_quantity , life_time_total_picks , lock_code , maximum_quantity , minimum_quantity , status , attribute1 , attribute2 , attribute3 , attribute4 , attribute5 , attribute6 , attribute7 , attribute8 ").where(:cl_warehouse_id => warehouse.cl_warehouse_id).where(search_string).paginate(
      :page     => params[:page],
      :per_page => params[:rows],
      :order    => order_by_from_params(params))
      
     if request.xhr?
        render :json => json_for_jqgrid(loc, columns)
     end
   end
   
 def upload
   file = params[:file].read
   CSV.parse(file) do |row|
   row_array = row
   error = is_row_valid row_array
   if error.blank?
      existloc = Location.where("cl_barcode = ? and  cl_warehouse_id = ?" , row_array[1], row_array[0]).first
      if existloc.nil?
      loc = Location.new(
                                  
                                   :cl_warehouse_id   => (row_array[0].to_s.encode! 'utf-8'),
                                   :cl_barcode  =>(row_array[1].to_s.encode! 'utf-8'),
                                   :current_item => (row_array[2].to_s.encode! 'utf-8'),
                                   :current_quantity => (row_array[3].to_s.encode! 'utf-8'),
                                   :life_time_total_picks  => (row_array[4].to_s.encode! 'utf-8'),
                                   :lock_code => (row_array[5].to_s.encode! 'utf-8'),
                                   :maximum_quantity =>(row_array[6].to_s.encode! 'utf-8'),
                                   :minimum_quantity => (row_array[7].to_s.encode! 'utf-8'),
                                   :status => (row_array[8].to_s.encode! 'utf-8')
                            
                       )
        
         loc.save
       else
        existloc.update_attributes({
                                          
                                           :cl_warehouse_id   => (row_array[0].to_s.encode! 'utf-8'),
                                           :cl_barcode  => (row_array[1].to_s.encode! 'utf-8'),
                                           :current_item => (row_array[2].to_s.encode! 'utf-8'),
                                           :current_quantity => (row_array[3].to_s.encode! 'utf-8'),
                                           :life_time_total_picks  => (row_array[4].to_s.encode! 'utf-8'),
                                           :lock_code => (row_array[5].to_s.encode! 'utf-8'),
                                           :maximum_quantity => (row_array[6].to_s.encode! 'utf-8'),
                                           :minimum_quantity => (row_array[7].to_s.encode! 'utf-8'),
                                           :status => (row_array[8].to_s.encode! 'utf-8')
                                       })
                                       
       end
         
      else

        locationerror = Locationerror.new(
        
                                                 :file_name => params[:file].original_filename + Time.now.to_s,
                                                 :error_description => error,
                                                 :attribute1 => (row_array[0].to_s.encode! 'utf-8'),
                                                 :attribute2 => (row_array[1].to_s.encode! 'utf-8'), 
                                                 :attribute3 => (row_array[2].to_s.encode! 'utf-8'),
                                                 :attribute4 => (row_array[3].to_s.encode! 'utf-8'),
                                                 :attribute5 => (row_array[4].to_s.encode! 'utf-8'),
                                                 :attribute6 => (row_array[5].to_s.encode! 'utf-8'),
                                                 :attribute7 => (row_array[6].to_s.encode! 'utf-8'),
                                                 :attribute8 => (row_array[7].to_s.encode! 'utf-8'),
                                                 :attribute9 => (row_array[8].to_s.encode! 'utf-8')
                                                   
                                          )
                                          
            locationerror.save
         
     end
  end 
   redirect_to :back 
 end
 def is_row_valid rowOfcsv
    error = ""
   #warehouse validation
   if warehouse = Warehouse.where(cl_warehouse_id: rowOfcsv[0]).first.nil?
     error = "Warehouse not found"
     
   end  
   #Barcode validation  
   if barcode = Position.where("cl_barcode = ? and  cl_warehouse_id = ?" , rowOfcsv[1], rowOfcsv[0]).first.nil?
     error = "Barcode not found"
      
   end
   
   #current quantity Should be greater than or equal to minimum quantity and less than or equal to maximum quantity
   if rowOfcsv[3].to_i >= rowOfcsv[6].to_i and rowOfcsv[3].to_i <= rowOfcsv[7].to_i
      error = "Current quantity not correct"
      
   end
     return error
   end

 def create
   
  case params[:oper]
  when "edit"
       update_location
        
  when "add"
         loc = Location.find_by_id(params[:id])
        
        loc= Location.new(
                                   :cl_loc_id   => params[:cl_loc_id],
                                   :cl_warehouse_id   => params[:cl_warehouse_id],
                                   :current_item => params[:current_item],
                                   :current_quantity => params[:current_quantity],
                                   :life_time_total_picks  => params[:life_time_total_picks],
                                   :lock_code => params[:lock_code],
                                   :maximum_quantity => params[:maximum_quantity],
                                   :minimum_quantity => params[:minimum_quantity],
                                   :status => params[:status],
                                   :sm_barcode  => params[:sm_barcode],
                                   :cl_barcode  => params[:cl_barcode],
                                   :attribute1 => params[:attribute1],
                                   :attribute2 => params[:attribute2], 
                                   :attribute3 => params[:attribute3],
                                   :attribute4 => params[:attribute4],
                                   :attribute5 => params[:attribute5],
                                   :attribute6 => params[:attribute6],
                                   :attribute7 => params[:attribute7],
                                   :attribute8 => params[:attribute8],
                                   :attribute9 => params[:attribute9]  
                         
                       )
        
         loc.save
           
             
   when "del"
               loc =  Location.destroy(params[:id].to_i)
           
   end
    
    
    if request.xhr?
        render :json => loc   
     end
 end
 
 def update_location
   
  loc = Location.find_by_id(params[:id])
        loc.update_attributes({ 
                                   :cl_loc_id   => params[:cl_pos_id],
                                   :cl_warehouse_id   => params[:cl_warehouse_id],
                                   :current_item => params[:current_item],
                                   :current_quantity => params[:current_quantity],
                                   :life_time_total_picks  => params[:life_time_total_picks],
                                   :lock_code => params[:lock_code],
                                   :maximum_quantity => params[:maximum_quantity],
                                   :minimum_quantity => params[:minimum_quantity],
                                   :status => params[:status],
                                   :sm_barcode  => params[:sm_barcode],
                                   :cl_barcode  => params[:cl_barcode],
                                   :attribute1 => params[:attribute1],
                                   :attribute2 => params[:attribute2], 
                                   :attribute3 => params[:attribute3],
                                   :attribute4 => params[:attribute4],
                                   :attribute5 => params[:attribute5],
                                   :attribute6 => params[:attribute6],
                                   :attribute7 => params[:attribute7],
                                   :attribute8 => params[:attribute8],
                                   :attribute8 => params[:attribute9]    
                                })
    
                               
   end
      
 end

 def get_header_details

   if cookies[:userid].nil? 
               redirect_to "/login"
    else
      @userid = cookies[:userid]
    end
 
end
