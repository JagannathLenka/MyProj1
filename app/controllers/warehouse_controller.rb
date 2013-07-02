class WarehouseController < ApplicationController

#Dynamically arranging bays in the aisle 
 
def index
  
  @aislehash=Hash.new
  
  aisle=Aisle.all
  aisle.each do |aislevalue|
  bay= Bay.where(aisle_id: aislevalue.aisle_id)
  bayhash = Hash.new
  
  bayhash= bayhash.merge({:aisleseparation => aislevalue.properties1})
    
  bay.each do |bayvalue|
      bayhash= bayhash.merge({bayvalue.bay_id =>{:type => bayvalue.properties1 , :item => bayvalue.properties2}})
      
    end
      
      @aislehash = @aislehash.merge(aislevalue.aisle_id => bayhash)

  end
end

#dynamically arranging position and level of the item in the  bay

def bay
  
 @id = params[:id]
 @poshash=Hash.new
 
 position = Position.where(bay_id: @id)
 
     position.each do |posvalue|
       
      @poshash = @poshash.merge({posvalue.pos_id => {:type =>posvalue.properties1 , :item => posvalue.properties2}})
       
     end
     
end

end
