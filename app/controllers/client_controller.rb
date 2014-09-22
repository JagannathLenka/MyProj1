class ClientController < ApplicationController
  
rescue_from Exception, :with => :error_render_method
  # GET /Render the JQGrid for slotting recomendation
  def index

     get_header_details  if !request.xhr?
     columns =  ['id', 'name_of_person','lastname_of_person','name_of_organization','email_id', 'no_of_license_required' ,
                  'phone_no1','phone_no2','state','country','zipcode','status']
                  
    clients = Client.select("*").paginate(
                     :page     => params[:page],
                     :per_page => params[:rows],
                     :order    => order_by_from_params(params))

      
      
     if request.xhr? 
       render :json => json_for_jqgrid(clients, columns)
     end

  end
 #Update the aisles and create bays and levels beased on the input from JQgrid
 def create
  
  @error = ""
  case params[:oper]
  when "edit"
       edit_client_details 
                
  when "add"
       clients = Client.new(
                                   :name_of_person => params[:name_of_person], 
                                   :lastname_of_person => params[:lastname_of_person],
                                   :name_of_organization => params[:name_of_organization],
                                   :email_id => params[:email_id],
                                   :no_of_license_required => params[:no_of_license_required],
                                   :phone_no1 => params[:phone_no1],
                                   :phone_no2 => params[:phone_no2],
                                   :state => params[:state],
                                   :country => params[:country],
                                   :zipcode => params[:zipcode],
                                   :status => params[:status]
                                   
                             ) 
                                   
        
        clients.save 
         
       
  when "del"
            
            params[:id].split(',').each{|id| Client.destroy(id.to_i)}    
   end        
    #If it is a Ajax then send the json details
    
    if request.xhr?
       if !@error.blank?        
        render :json => @error.to_json, status: 500
       else
        render :json => clients
        end
    end 
 end
 
 
 def edit_client_details
 
         clients = Client.find_by_id(params[:id])  
         clients.update_attributes({ 
                                    :name_of_person => params[:name_of_person], 
                                   :lastname_of_person => params[:lastname_of_person],
                                   :name_of_organization => params[:name_of_organization],
                                   :email_id => params[:email_id],
                                   :no_of_license_required => params[:no_of_license_required],
                                   :phone_no1 => params[:phone_no1],
                                   :phone_no2 => params[:phone_no2],
                                   :state => params[:state],
                                   :country => params[:country],
                                   :zipcode => params[:zipcode],
                                   :status => params[:status] 
                                  })
                                  
 end
 #Write the breadcrumbs
 def get_header_details
 
 end 
 
 #Error Handling
def error_render_method exception
      
      render :json => "Error: PLEASE CONTACT YOUR IT " + "\n" + exception.message , status: 500
      true
  end 
    
end
