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
 
   newuser = User.where(user_id: params[:txtuid]).first
      if newuser.nil?
           render :text => "Error:Incorrect User" 

      elsif   newuser.password == params[:txtpswd]
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
      end
          
 end

 def aboutus
   
 end
 
 def landingpage
   
 end
 
 
end
