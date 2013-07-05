class BayController < ApplicationController
  
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

#Update the new id
def create
  
   case params[:warehouse][:event]
      when "update_position" 
       newbay= Bay.where("bay_id = ?", params[:warehouse][:bay_id] ).first
       newbay.customer_bay_id = params[:warehouse][:customer_bay_id] 
       newbay.save
       
#Updating class and title after dragging
  
   when "update_class"

        dragbay=Bay.where("bay_id = ?" , params[:warehouse][:dragbay_id]).first
        dragbay.properties1 = params[:warehouse][:dragbay_class]
        dragbay.properties2 = params[:warehouse][:dragbay_title]
        dragbay.save
        dropbay=Bay.where("bay_id = ?" , params[:warehouse][:dropbay_id]).first
        dropbay.properties1 = params[:warehouse][:dropbay_class]
        dropbay.properties2 = params[:warehouse][:dropbay_title]
        dropbay.save
        
   end    
       render text: "ok"
   #b= Posts.where("text = ?", params[:post][:text]).first
   
end
  
  
  
end
