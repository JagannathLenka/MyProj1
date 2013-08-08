class UserregisterController < ApplicationController
  def index
    
  end
  def create
    newclient = Client.new(name_of_organization: params[:name_of_organization], address1: params[:address1], address2: params[:address2], zipcode: params[:zipcode], state: params[:state], country: params[:country],
     phone_no1: params[:phone_no1], phone_no2: params[:phone_no2], email_id: params[:email_id], name_of_person: params[:name_of_person], no_of_license_required: params[:no_of_license_required] )
    newclient.save ?  (render "thanks") : (render text: "Error in Page")
  end
  
=begin
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
=end
  
  
  def new
    
  end
end
