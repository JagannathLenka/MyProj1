class UsermaintenanceController < ApplicationController

  def index
    
  end
  def create
    case params[:commit]
      when "Save User"
        newuser = User.new(client_id: params[:txt1], user_id: params[:txt2], user_name: params[:txt3], password: params[:txt4], email_id: params[:txt5], contact_phone: params[:txt6], last_login: params[:txt7], status: params[:txt8] )
        newuser.save
      when "Edit User"
        finduser = User.where(client_id:params[:txt1])
        @u = finduser.each do |uservalue|
          uservalue.update_attributes({:user_id => params[:txt2]}) 
        end
      end
        render text: "User Created"
  end
  
  def new
    @user = User.new
  end

end
