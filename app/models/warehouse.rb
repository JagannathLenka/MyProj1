class Warehouse < ActiveRecord::Base
  has_many :zones, :dependent => :destroy
  after_save :update_zones
  
  attr_accessible :attribute1, :attribute2, :attribute3, :attribute4, :attribute5, :attribute6, :attribute7, :attribute8, :cl_warehouse_id, :client_id, :description, :no_of_zones, :sm_warehouse_id
  validates :cl_warehouse_id, :uniqueness => { :allow_nil => true, :allow_blank => true,  :message => "Warehouse Already Exists"}
  
  def update_zones
     if cl_warehouse_id_changed?
       zones = Zone.where(:warehouse_id => self.id)
       zones.each do |zone|
       zone.update_attributes({:cl_warehouse_id => self.cl_warehouse_id})
       end
     end
  end

end
