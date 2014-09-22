class CreateUsers < ActiveRecord::Migration
  def up
    create_table :users do |t|
      t.string   "client_id"
      t.integer  "contact_phone"
      t.string   "user_name"
      t.string   "user_id"
      t.string   "email_id"
      t.string   "password"
      t.string   "last_login"
      t.string   "status"
      t.string   "attribute1"
      t.string   "attribute2"
      t.string   "attribute3"
      t.string   "attribute4"
      t.string   "attribute5"
      t.string   "attribute6"
      t.string   "attribute7"
      t.string   "attribute8"
      t.integer  "contact_phone2"
      t.string   "attribute9"
      t.string   "attribute10"
      t.string   "attribute11"
      t.string   "attribute12"
      t.string   "attribute13"
      t.string   "attribute14"
      t.string   "attribute15"
      t.string   "attribute16"
      t.string   "attribute17"
      t.string   "attribute18"
      t.string   "attribute19"
      t.string   "attribute20"

      t.timestamps
    end
  end
  
  def down
    drop_table :users
  end
end
