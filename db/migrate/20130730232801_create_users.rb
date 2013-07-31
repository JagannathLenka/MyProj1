class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :client_id
      t.integer :contact_phone
      t.string :user_name
      t.string :user_id
      t.string :email_id
      t.string :password
      t.string :last_login
      t.string :status
      t.string :attribute1
      t.string :attribute2
      t.string :attribute3
      t.string :attribute4
      t.string :attribute5
      t.string :attribute6
      t.string :attribute7
      t.string :attribute8

      t.timestamps
    end
  end
end
