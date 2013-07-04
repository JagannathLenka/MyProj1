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
      if bayvalue.customer_bay_id.blank?
        customer_bay_id = bayvalue.bay_id
      else
        customer_bay_id = bayvalue.customer_bay_id
      end
      bayhash= bayhash.merge({bayvalue.bay_id =>{:type => bayvalue.properties1 , :item => bayvalue.properties2, :customerid => customer_bay_id}})
      
    end
      
      @aislehash = @aislehash.merge(aislevalue.aisle_id => bayhash)

  end
end

#update the new id
def create
  
   case params[:warehouse][:event]
      when "update_position" 
       newbay= Bay.where("bay_id = ?", params[:warehouse][:bay_id] ).first
       newbay.customer_bay_id = params[:warehouse][:customer_bay_id] 
       newbay.save
   end    
       render text: "ok"
   #b= Posts.where("text = ?", params[:post][:text]).first
end

#dynamically arranging position and level of the item in the  bay

  def bay
  
    @id = params[:id]
    @levelhash=Hash.new
    level = Level.where(bay_id: @id)
    level.each do |levelvalue|
      pos = Position.where("level_id = ? AND bay_id = ?", levelvalue.level_id, @id)
      poshash=Hash.new
      poshash= poshash.merge({:leveltype => levelvalue.properties1})
      pos.each do |posvalue|
        poshash = poshash.merge({posvalue.pos_id => {:postype => posvalue.properties1 , :item => posvalue.properties2}})
        
      end
      @levelhash = @levelhash.merge(levelvalue.level_id  => poshash)
    
    end
  
  end
  
  
  
end