class CreateClients < ActiveRecord::Migration
  def up
    create_table :clients do |t|
      t.string   "name_of_organization"
      t.integer  "address1"
      t.string   "address2"
      t.string   "zipcode"
      t.string   "state"
      t.string   "country"
      t.integer  "phone_no1"
      t.integer  "phone_no2"
      t.string   "email_id"
      t.string   "name_of_person"
      t.string   "status"
      t.string   "no_of_license_required"
      t.string   "attribute1"
      t.string   "attribute2"
      t.string   "attribute3"
      t.string   "attribute4"
      t.string   "attribute5"
      t.string   "attribute6"
      t.string   "attribute7"
      t.string   "attribute8"
      t.string   "lastname_of_person"

      t.timestamps
    end
  end
  
  def down
    drop_table :clients
  end 
end
