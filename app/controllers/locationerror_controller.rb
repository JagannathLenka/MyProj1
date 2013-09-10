class LocationerrorController < ApplicationController
  
   # GET /maintenance
  def index
    
 
   columns =  ['id','file_name', 'transaction_id','sequence_no','error_code', 'error_description', 'attribute1','attribute2','attribute3','attribute4','attribute5','attribute6','attribute7','attribute8','attribute9']
   locationerror = Locationerror.select(" id ,file_name , transaction_id ,sequence_no , error_code , error_description ,  attribute1 , attribute2 , attribute3 , attribute4, attribute5, attribute6 , attribute7 , attribute8 , attribute9").where(get_searchstring).paginate(
      :page     => params[:page],
      :per_page => params[:rows],
      :order    => order_by_from_params(params))
  
    if request.xhr? 
    render :json => json_for_jqgrid(locationerror, columns)
    end
    
  end
  
  def get_searchstring 
     search_string = '1 = 1'
     if params[:_search] == "true"
      case params[:searchOper]
      when 'eq'
        search_string = params[:searchField] + " = '" +  params[:searchString] + "'"
      when 'bw'
        search_string = params[:searchField] + " like '" +  params[:searchString] + "%'"
      end 
     end
     return search_string
  end
  
 def create
  
   case params[:oper]
   when "edit" 
       
       locationerror = Locationerror.find_by_id(params[:id])
       locationerror.update_attributes({
                                          
                                           :attribute1 => params[:attribute1],
                                           :attribute2 => params[:attribute2], 
                                           :attribute3 => params[:attribute3],
                                           :attribute4 => params[:attribute4],
                                           :attribute5 => params[:attribute5],
                                           :attribute6 => params[:attribute6],
                                           :attribute7 => params[:attribute7],
                                           :attribute8 => params[:attribute8],
                                           :attribute9 => params[:attribute9]
                                              
                                       })
                                       
    when "del"  
       Locationerror.destroy(params[:id].to_i) 
       
    when "proc"
       
       reprocess                                  
      
   end
   
   
    if request.xhr?
       render :json => locationerror
    end
  end
  
  #reprocessing the error in locationerror
  def reprocess
   ids = params[:id]
   ids.each do |id|
   locationerror = Locationerror.find(id.to_i)
   error =  is_row_valid locationerror 
   if error.blank?
      existloc = Location.where("cl_barcode = ? and  cl_warehouse_id = ?" , locationerror.attribute2, locationerror.attribute1).first
      
      if existloc.nil?
         loc = Location.new(
                                  
                                   :cl_warehouse_id   => locationerror.attribute1,
                                   :cl_barcode  =>locationerror.attribute2,
                                   :current_item => locationerror.attribute3,
                                   :current_quantity => locationerror.attribute4,
                                   :life_time_total_picks  => locationerror.attribute5,
                                   :lock_code => locationerror.attribute6,
                                   :maximum_quantity =>locationerror.attribute7,
                                   :minimum_quantity => locationerror.attribute8,
                                   :status => locationerror.attribute9
                            
                       )
        
         loc.save
         
       else
        existloc.update_attributes({
                                          
                                       :cl_warehouse_id   => locationerror.attribute1,
                                       :cl_barcode  =>locationerror.attribute2,
                                       :current_item => locationerror.attribute3,
                                       :current_quantity => locationerror.attribute4,
                                       :life_time_total_picks  => locationerror.attribute5,
                                       :lock_code => locationerror.attribute6,
                                       :maximum_quantity =>locationerror.attribute7,
                                       :minimum_quantity => locationerror.attribute8,
                                       :status => locationerror.attribute9
                                       
                                   })
                                   
                                       
       end
       
       Locationerror.destroy(id.to_i) 
        
      else

          locationerror.update_attributes({
                                          
                                      :error_description => error
                                       
                                   })
       end
  end 
   
 end
 def is_row_valid loc
    error = ""
   #warehouse validation
   
   if warehouse = Warehouse.where(cl_warehouse_id: loc.attribute1).first.nil?
     error = "Warehouse not found"
     
   end  
   #Barcode validation  
   if barcode = Position.where("cl_barcode = ? and  cl_warehouse_id = ?" , loc.attribute2, loc.attribute1).first.nil?
     error = error + "," +  "Barcode not found"
      
   end
   
   #current quantity Should be greater than or equal to minimum quantity and less than or equal to maximum quantity
   if loc.attribute4.to_i >= loc.attribute7.to_i and loc.attribute4.to_i <= loc.attribute8.to_i
      error = error + "," + "Current quantity not correct"
      
   end
     return error
   end


end
