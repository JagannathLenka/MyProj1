class LoginController < ApplicationController
   def index
    
  end
  def create
 
    u = User.where(user_id:params[:txtuid]).first
      if u.nil?
           
           flash[:notice] = "Incorrect User"
           redirect_to :back
          
   
     elsif u.password == params[:txtpswd]
              redirect_to "/warehousemaintenance"
     else
       flash[:notice] = "Incorrect Password"
       redirect_to :back
     end
  
          
          
 end
end
