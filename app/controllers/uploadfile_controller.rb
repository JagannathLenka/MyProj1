class UploadfileController < ApplicationController
   # GET /Render the JQGrid for slotting recomendation
  def index

     get_header_details  if !request.xhr?
     columns =  ['id', 'client_id','upload_filename', 'created_at', 'no_of_records','no_of_processed_records','no_of_error_records','attribute1','attribute2']
      uploadfiles = Uploadfile.select("*")
                     .where(get_searchstring )
                     .paginate(
                     :page     => params[:page],
                     :per_page => params[:rows],
                     :order    => order_by_from_params(params))

      
      
     if request.xhr? 
       render :json => json_for_jqgrid(uploadfiles, columns)
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
  
  def upload
    
        uploadfile = Uploadfile.new(
                                      :client_id => cookies[:client_id],
                                      :upload_filename => params[:file].original_filename,
                                      :no_of_records => 0,
                                      :no_of_processed_records => 0,
                                      :no_of_error_records => 0,
                                      :attribute1 => "Uploaded"  
                                   )
      
       uploadfile.save
        
       file= params[:file].read
       #to identify the file type e.g. itemmaster or location
      case params[:file].original_filename
         
       when "Item.csv"
         Itemmaster.delay.upload_file  uploadfile.id , file , params[:file].original_filename
         
       when "Location.csv"
         Location.delay.upload_file uploadfile.id , file , params[:file].original_filename
      end
      redirect_to :back 
  end
  
  def create
    
  end
 #Write the breadcrumbs
 def get_header_details
   
    
 end 

end
