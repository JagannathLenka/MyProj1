class Level < ActiveRecord::Base
  has_many :positions, :dependent => :destroy
  
  after_save :update_positions
  after_destroy :update_bays_for_delete
  after_create  :update_bays_for_add
  
  attr_accessible :attribute1, :attribute2, :attribute3, :attribute4, :attribute5, :attribute6, :attribute7, :attribute8, :bay_id, :cl_aisle_id, :cl_bay_id, :cl_level_id, :cl_warehouse_id, :cl_zone_id, :client_id, :description, :no_of_pos_level, :sm_aisle_id, :sm_bay_id, :sm_level_id, :sm_warehouse_id, :sm_zone_id
  validates :cl_level_id, :uniqueness => {:scope => :bay_id , :allow_nil => true, :allow_blank => true,  :message => "Level Already Exists"}
  def update_positions
     if cl_warehouse_id_changed? or cl_zone_id_changed? or cl_aisle_id_changed? or cl_bay_id_changed? or cl_level_id_changed?
         positions = Position.where(:level_id => self.id)
         positions.each do |position|
         position.update_attributes({
               :cl_warehouse_id => self.cl_warehouse_id,
               :cl_zone_id => self.cl_zone_id,
               :cl_aisle_id => self.cl_aisle_id,
               :cl_bay_id => self.cl_bay_id,
               :cl_level_id => self.cl_level_id
               })
       end        
     end
  end
  
  def update_bays_for_delete
    bay = Bay.find(self.bay_id)
    bay.update_attributes({:no_of_level_bay => bay.no_of_level_bay.to_i - 1})
    
  end
  
 def update_bays_for_add
   bays = Bay.find(self.bay_id)
   bays.update_attributes({ :no_of_level_bay => bays.no_of_level_bay.to_i + 1})
    
  end 
end
