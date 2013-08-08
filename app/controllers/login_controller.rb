class LoginController < ApplicationController
   def index
    
  end
  def create
 
   newuser = User.where(user_id:params[:txtuid]).first
      if newuser.nil?
           
           flash[:notice] = "Incorrect User"
           redirect_to :back
          
   
     elsif newuser.password == params[:txtpswd]
              newuser.last_login = Time.now.to_s
              newuser.save
              redirect_to "/warehousemaintenance"
     else
       flash[:notice] = "Incorrect Password"
       redirect_to :back
     end
  
          
          
 end
end
