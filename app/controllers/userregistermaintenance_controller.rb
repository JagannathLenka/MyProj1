class UserregistermaintenanceController < ApplicationController
  # GET /maintenance
  def index
    
    columns =  ['id','name_of_person','lastname_of_person','email_id', 'client_id','phone_no1', 'phone_no2' , 'name_of_organization','Address1','Address2','zipcode','state','country','no_of_license_required' , 'attribute1','attribute2','attribute3','attribute4','attribute5','attribute6','attribute7','attribute8' ]
    user = User.select(" id , name_of_person , lastname_of_person , email_id , client_id , phone_no1 , phone_no2 , name_of_organization ,Address1, Address2 ,
    zipcode , state , country , no_of_license_required  , attribute1 , attribute2 , attribute3 , attribute4,
    attribute5, attribute6 , attribute7 , attribute8 ").paginate(
      :page     => params[:page],
      :per_page => params[:rows],
      :order    => order_by_from_params(params))
  
    if request.xhr?
      #@invoices = 'ok'
      render :json => json_for_jqgrid(user, columns)
    end

  end


 
 def create
   
  case params[:oper]
  when "edit"
        client = Client.find_by_id(params[:id])
        client.update_attributes({
                                   :name_of_person => params[:name_of_person],
                                   :lastname_of_person => params[:lastname_of_person],
                                   :email_id => params[:email_id],
                                   :client_id => params[:client_id],
                                   :phone_no1 => params[:phone_no1],
                                   :phone_no2 => params[:phone_no2],
                                   :name_of_organization => params[:name_of_organization],
                                   :address1 => params[:address1],
                                   :address2 => params[:address2],
                                   :zipcode => params[:zipcode], 
                                   :state => params[:state],
                                   :country => params[:country],
                                   :no_of_license_required => params[:no_of_license_required],
                                   
                                        
          })
          

 
  when "add"
        
       client = Client.new(
                                   :name_of_person => params[:name_of_person],
                                   :lastname_of_person => params[:lastname_of_person],
                                   :email_id => params[:email_id],
                                   :client_id => params[:client_id],
                                   :phone_no1 => params[:phone_no1],
                                   :phone_no2 => params[:phone_no2],
                                   :name_of_organization => params[:name_of_organization],
                                   :address1 => params[:address1],
                                   :address2 => params[:address2],
                                   :zipcode => params[:zipcode], 
                                   :state => params[:state],
                                   :country => params[:country],
                                   :no_of_license_required => params[:no_of_license_required],
                                   
                                        
          )
         
         client.save
          
                             
    when "del"
              Client.destroy(params[:id].to_i)                               
    end
    if request.xhr?
      render :json => client
    end
end 



end
