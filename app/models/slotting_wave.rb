class SlottingWave < ActiveRecord::Base
  attr_accessible :attribute1, :attribute2, :attribute3, :attribute4, :attribute5, :attribute6, :attribute7, :attribute8, :client_id, :preffered_aisle, :preffered_bay, :preffered_level, :preffered_position, :preffered_slotting_rules, :preffered_zone, :preffered_warehouse, :wave_number, :wave_status
  after_save     :add_slott_items, :if => :wave_status_changed? 
  
  
  def add_slott_items
    
    if self.wave_status_was == "Open" and self.wave_status =="Selected"
      
    end
    
  end
end
