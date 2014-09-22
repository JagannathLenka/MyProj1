class User < ActiveRecord::Base
  attr_accessible :attribute1, :attribute2, :attribute3, :attribute4, :attribute5, :attribute6, :attribute7, :attribute8,:attribute9, :attribute10, :attribute11, :attribute12, :attribute13, :attribute14, :attribute15, :attribute16, :attribute17, :attribute18, :attribute19, :attribute20, :client_id, :contact_phone, :contact_phone2, :email_id, :last_login, :password, :status, :user_id, :user_name
  
  def self.authenticate password
    if password == self.password
      true
    end
    false
  end

end
