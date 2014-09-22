class SlottingWave < ActiveRecord::Base
  attr_accessible :attribute1, :attribute2, :attribute3, :attribute4, :attribute5, :attribute6, :attribute7, :attribute8, :client_id, :preffered_aisle, :preffered_bay, :preffered_level, :preffered_position, :preffered_slotting_rules, :preffered_zone, :preffered_warehouse, :wave_number, :wave_status
  after_save     :add_slott_items, :if => :wave_status_changed? 
  
  
  def add_slott_items
    
    if self.wave_status_was == "Open" and self.wave_status =="Selected"
      slotting_ruledetails = SlottingruleDetails.where(:rule_id => self.preffered_slotting_rules)
      selection_criterias = Array.new
      selection_criteria = ""
      slotting_ruledetails.each do |slotting_ruledetail|
          selection_criteria = slotting_ruledetail.rule_description + " " +  slotting_ruledetail.attribute1 + " " + "('" + slotting_ruledetail.attribute2 + "')"
        
          logger.debug selection_criteria
        
      end
      items = Itemmaster.where(selection_criteria)
      items.each do |item|
        
         slotting_reco= Slottingrecommendation.new(
                                     :item_number => item.item_number, 
                                     :preffered_warehouse => self.preffered_warehouse,
                                     :preffered_zone => self.preffered_zone,
                                     :preffered_aisle => self.preffered_aisle,
                                     :preffered_bay => self.preffered_bay,
                                     :preffered_level => self.preffered_level,
                                     :preffered_position => self.preffered_position,
                                     :preffered_slotting_rules => self.preffered_slotting_rules,
                                     :slotting_status => 'Open',
                                     :attribute1 => self.id,
                                     :attribute2 => self.wave_number
                            )
          
           slotting_reco.save 
      end
    end
    
  end
end
