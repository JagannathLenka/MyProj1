class WarehouseController < ApplicationController
  
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

def bay
 @id = params[:id]
 
end

end
