module PositionHelper
  
  def poistion_tooltip posvalue
  
      tooltip =   
     "Item          :" + posvalue[:item].to_s               + "\n" + 
     "Current Inv   :" + posvalue[:current_inventory].to_s  + "\n" +  
     "Maximum Inv   :" + posvalue[:maximum_quantity].to_s   + "\n" +  
     "Minimum Inv   :" + posvalue[:minimum_quantity].to_s   + "\n" + 
     "Lock Code     :" + posvalue[:lock_code].to_s  
     return tooltip
      
  end

end
