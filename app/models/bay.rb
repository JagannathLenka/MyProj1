class Bay < ActiveRecord::Base
  has_many :levels, :dependent => :destroy
  
  after_save :update_levels
  after_destroy :update_aisles_for_delete
  after_create :update_aisles_for_add
  
  attr_accessible :aisle_id, :attribute1, :attribute2, :attribute3, :attribute4, :attribute5, :attribute6, :attribute7, :attribute8, :cl_aisle_id, :cl_bay_id, :cl_warehouse_id, :cl_zone_id, :client_id, :description, :no_of_level_bay, :sm_aisle_id, :sm_bay_id, :sm_warehouse_id, :sm_zone_id
  validates :cl_bay_id, :uniqueness => {:scope => :aisle_id , :allow_nil => true, :allow_blank => true,  :message => "Bay Already Exists"}
  
  def update_levels
    if cl_warehouse_id_changed? or cl_zone_id_changed? or cl_aisle_id_changed? or cl_bay_id?
     levels = Level.where(:bay_id => self.id)
     levels.each do |level|
     level.update_attributes({
           :cl_warehouse_id => self.cl_warehouse_id,
           :cl_zone_id => self.cl_zone_id,
           :cl_aisle_id => self.cl_aisle_id,
           :cl_bay_id => self.cl_bay_id
           })
     end
     end
  end
  
  def update_aisles_for_delete
    aisle = Aisle.find(self.aisle_id)
    aisle.update_attributes({:no_of_bays_aisle => aisle.no_of_bays_aisle.to_i - 1}) 
  end
  
  def update_aisles_for_add
    aisles = Aisle.find(self.aisle_id)
    aisles.update_attributes({:no_of_bays_aisle => aisles.no_of_bays_aisle.to_i + 1}) 
  end
end
