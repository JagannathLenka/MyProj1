class UsermaintenanceController < ApplicationController
# GET /maintenance
  def index

    columns =  ['id','client_id','user_id','user_name', 'password','email_id', 'contact_phone','status','last_login', 'attribute1','attribute2','attribute3','attribute4','attribute5','attribute6','attribute7','attribute8' ]
    user = User.select(" id ,client_id ,user_id, user_name, password ,email_id, contact_phone , status , last_login , attribute1 , attribute2 , attribute3 , attribute4,
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
        user = User.find_by_id(params[:id])
        user.update_attributes({
                                   :client_id => params[:client_id],
                                   :user_id => params[:user_id],
                                   :user_name => params[:user_name],
                                   :password => params[:password],
                                   :email_id => params[:email_id],
                                   :contact_phone => params[:contact_phone],
                                   :status => params[:status],
                                   :last_login => params[:last_login],
                                   :attribute1 => params[:attribute1],
                                   :attribute2 => params[:attribute2], 
                                   :attribute3 => params[:attribute3],
                                   :attribute4 => params[:attribute4]
                                        
          })
          

 
  when "add"
        maximum_user_id = User.maximum("id").to_i 
        user= User.new(   :client_id => params[:client_id],
                                   :user_id => params[:user_id],
                                   :user_name => params[:user_name],
                                   :password => params[:password],
                                   :email_id => params[:email_id],
                                   :contact_phone => params[:contact_phone],
                                   :status => params[:status],
                                   :last_login => params[:last_login],
                                   :attribute1 => params[:attribute1],
                                   :attribute2 => params[:attribute2], 
                                   :attribute3 => params[:attribute3],
                                   :attribute4 => params[:attribute4]
          )
        
         user.save          
        
                             
    when "del"
              User.destroy(params[:id].to_i)                               
    end
    if request.xhr?
      render :json => user
    end
end 

  
      
    
  

end
