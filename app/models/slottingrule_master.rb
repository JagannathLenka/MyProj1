class SlottingruleMaster < ActiveRecord::Base
  attr_accessible :attribute1, :attribute10, :attribute11, :attribute12, :attribute2, :attribute3, :attribute4, :attribute5, :attribute6, :attribute7, :attribute8, :attribute9, :description, :priority, :status, :users
  
  validates :priority, :uniqueness => {:allow_nil => false, :allow_blank => false,  :message => "Duplicate priority"}
end
