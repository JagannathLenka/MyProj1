class LoginController < ApplicationController
  skip_before_filter :login_require
  
   def index
    if params["logout"] == "yes"
      cookies.delete :userid
      
    end
  end
  def create
 
   newuser = User.where(user_id:params[:txtuid]).first
      if newuser.nil?
           
           #flash[:notice] = "Incorrect User"
           render :text => "Error:Incorrect User" 
           #redirect_to :back
          
   
     elsif newuser.password == params[:txtpswd]
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
             render :text => "Success"
     else
       #flash[:notice] = "Incorrect Password"
       #render :text => "Error:Incorrect Password"
       #redirect_to :back
       render :text => "Success"
     end
  
          
          
 end
end
