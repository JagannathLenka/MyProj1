class LoginController < ApplicationController
   def index
    
  end
  def create
 
    u = User.where(user_name:params[:txt1]).first
      if u.nil?
           
           flash[:notice] = "Incorrect User"
           redirect_to :back
          
   
     elsif u.password == params[:txt2]
              redirect_to "/warehousemaintenance"
     else
       flash[:notice] = "Incorrect Password"
       redirect_to :back
     end
  
          
          
 end
end
