class Position < ActiveRecord::Base
  
  before_save   :update_positions
  after_destroy :update_level_for_delete
  after_create  :update_level_for_add
  
  attr_accessible :attribute1, :attribute10, :attribute11, :attribute12, :attribute13, :attribute14, :attribute15, :attribute16, :attribute2, :attribute3, :attribute4, :attribute5, :attribute6, :attribute7, :attribute8, :attribute9, :cl_aisle_id, :cl_barcode, :cl_bay_id, :cl_level_id, :cl_pos_id, :cl_warehouse_id, :cl_zone_id, :client_id, :description, :level_id, :sm_aisle_id, :sm_barcode, :sm_bay_id, :sm_level_id, :sm_pos_id, :sm_warehouse_id, :sm_zone_id

  def update_positions
   case self.attribute1
    when "Default"
    self.cl_barcode = cl_zone_id.to_s + "-" + cl_aisle_id.to_s + "-" + cl_bay_id.to_s + "-" + cl_level_id.to_s + "-" + cl_pos_id.to_s
    end
  end
  
  def update_level_for_delete
    level = Level.find(self.level_id)
    level.update_attributes({:no_of_pos_level => level.no_of_pos_level - 1})
  end
  
  def update_level_for_add
     levels = Level.find(self.level_id)
     levels.update_attributes({:no_of_pos_level => levels.no_of_pos_level.to_i + 1}) 
  end
end
