class LoginController < ApplicationController
  skip_before_filter :login_require
  
   def index
    if params["logout"] == "yes"
      cookies.delete :userid
      cookies.delete :client_id
      cookies.delete :last_url
    end
  end
  
  def create
   
   #To Keep the session alive 
   if params[:session]=='live'                 
              cookies[:userid] = {                                  
                                  expires: 1.hour.from_now
                                }
             cookies[:client_id] = {                    
                    expires: 1.hour.from_now                    
                  }   
   validationResponse = "Sucessess"                           
   else

      
    newuser = User.where(user_id: params[:txtuid] , password: params[:txtpswd] ).first
    validationResponse = isValidUser? newuser
    if  validationResponse == "Success"
            newuser.last_login = Time.now.to_s
            newuser.save   
            cookies[:userid] = {
                                value: newuser.user_id,
                                expires: 1.hour.from_now
                              }
     
            cookies[:client_id] = {
                  value: newuser.client_id,
                  expires: 1.hour.from_now              
                }
    end
       
   end
  
    render :text => validationResponse      
 
 end
 
 #Check if this a valid user
 def isValidUser? newuser
   
   case 
           
       when params[:txtuid].nil?
            return "Error: Please enter the password" 

       when params[:txtpswd].nil?
            return "Error: Please enter the password" 
        
       when newuser.nil?    
            return "Error: Invalid user id"

       when newuser.password != params[:txtpswd]
            return "Error: Invalid user id or password" 
            
       else
            return "Success"  
   end
   
 end  
 

 def aboutus
   
 end
 
 def landingpage
   
 end
 
 
end
