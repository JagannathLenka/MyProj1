class Client < ActiveRecord::Base
  attr_accessible :address1, :address2, :attribute1, :attribute2, :attribute3, :attribute4, :attribute5, :attribute6, :attribute7, :attribute8, :country, :email_id, :name_of_organization, :name_of_person, :lastname_of_person, :no_of_license_required, :phone_no1, :phone_no2, :state, :status, :zipcode
end
