class LocationerrorController < ApplicationController
  
   # GET /maintenance
  def index
    
 
   columns =  ['id','file_name', 'transaction_id','sequence_no','error_code', 'error_description', 'attribute1','attribute2','attribute3','attribute4','attribute5','attribute6','attribute7','attribute8','attribute9','attribute10']
   locationerror = Locationerror.select(" id ,file_name , transaction_id ,sequence_no , error_code , error_description ,  attribute1 , attribute2 , attribute3 , attribute4, attribute5, attribute6 , attribute7 , attribute8 , attribute9 , attribute10 ").where(get_searchstring).paginate(
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
     
     
     if !params[:uploadfile_id].nil?
        search_string = "uploadfile_id =" +  params[:uploadfile_id]
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
                                           :attribute9 => params[:attribute9],
                                           :attribute10 => params[:attribute10]
                                       })
                                       
    when "del"  
 
       params[:id].split(',').each do |id|
         locationerror = Locationerror.find(id.to_i)
          Locationerror.destroy(id.to_i)
          upload_file = Uploadfile.find(locationerror.uploadfile_id)
          upload_file.no_of_error_records -= 1
          upload_file.save
       end
       
    when "proc"
       
       locationerror = reprocess                                  
      
   end
   
   
    if request.xhr?
       render :json => locationerror.to_json
    end
  end
  
  #reprocessing the error in locationerror
  def reprocess
   ids = params[:id]
   errorExists = false
   ids.each do |id|
       locationerror = Locationerror.find(id.to_i)
       error =  is_row_valid locationerror 
       if error.blank?
         
                      locationHash = {
                                                   :client_id  => locationerror.attribute1,
                                                   :cl_warehouse_id   => locationerror.attribute2,
                                                   :cl_barcode  =>locationerror.attribute3,
                                                   :current_item => locationerror.attribute4,
                                                   :current_quantity => locationerror.attribute5,
                                                   :life_time_total_picks  => locationerror.attribute6,
                                                   :lock_code => locationerror.attribute7,
                                                   :maximum_quantity =>locationerror.attribute8,
                                                   :minimum_quantity => locationerror.attribute9,
                                                   :status => locationerror.attribute10,
                                                   :location_length => locationerror.attribute11,
                                                   :location_breadth => locationerror.attribute12,
                                                   :location_height => locationerror.attribute13,
                                                   :location_volume => locationerror.attribute14,
                                                   :allowed_weight => locationerror.attribute15,
                                                   :item_short_description => locationerror.attribute16,
                                                   :item_long_description => locationerror.attribute17     
                                      
                                      }
                      existloc = Location.where("client_id = ? and cl_barcode = ? and  cl_warehouse_id = ?" , locationerror.attribute1, locationerror.attribute3 , locationerror.attribute2).first
                
                      if existloc.nil?
                         loc = Location.new(locationHash)
                         loc.save
                         Location.update_location_details loc, locationerror.attribute2, locationerror.attribute3
                         
                       else
                        existloc.update_attributes(locationHash)
                                                      
                       end
                       
                       Locationerror.destroy(id.to_i) 
                        upload_file = Uploadfile.find(locationerror.uploadfile_id)
                        upload_file.no_of_error_records -= 1
                        upload_file.no_of_processed_records += 1
                        upload_file.save
                        
         else
                     
                          locationerror.update_attributes({
                                                          
                                                      :error_description => error
                                                       
                                                   })
                          errorExists = true
                         
        end
       
       return (errorExists  ? "Error Exists in processing" : "Processed Successfully")   
  end 
   
 end
 
 def is_row_valid loc
   
    error = ""
    
    #ClientId validation
    if client = User.where(client_id: loc.attribute1).first.nil?
     error = "ClientId not found" 
   end 
    
   #warehouse validation
   if warehouse = Warehouse.where(cl_warehouse_id: loc.attribute2).first.nil?
     error += (error.blank? ? "" : ",") + "Warehouse not found"
   end  
   
   #Barcode validation  
   if barcode = Position.where("cl_barcode = ? and  cl_warehouse_id = ?" , loc.attribute3, loc.attribute2).first.nil?
     error += (error.blank? ? "" : ",") +  "Barcode not found"   
   end
   
   #current quantity Should be greater than or equal to minimum quantity and less than or equal to maximum quantity
   if loc.attribute5.to_i > loc.attribute8.to_i
      error += (error.blank? ? "" : ",") + "Current quantity is more than maximum quantity"
      
   end
   
   #if loc.attribute5.to_i < loc.attribute9.to_i
    # error += (error.blank? ? "" : ",") + "Current quantity is less than minimum quantity "
   #end
   
     return error
   end


end
