class BayController < ApplicationController
  
#Dynamically arranging bays in the aisle 
 
def index
  
  @aislehash=Hash.new
  
  #aisle=Aisle.all
  aisle = Aisle.where(zone_id: params[:id])
  aisle.each do |aislevalue|
  bay= Bay.where(aisle_id: aislevalue.id)
  bayhash = Hash.new
  
  bayhash= bayhash.merge({:aisleseparation => aislevalue.attribute1})
    
  bay.each do |bayvalue|
      if bayvalue.cl_bay_id.blank?
        customer_bay_id = bayvalue.id
      else
        customer_bay_id = bayvalue.cl_bay_id
      end
      baytype =  bayvalue.attribute1.blank?  ?  "bay_Empty"  :  bayvalue.attribute1 
      bayhash= bayhash.merge({bayvalue.id =>{:type => baytype , :item => bayvalue.attribute2, :customerid => customer_bay_id}})
      
    end
      
      @aislehash = @aislehash.merge(aislevalue.id => bayhash)

  end
end

def create
  
#Update the customer id for a bay  
   case params[:bay][:event]
      when "update_position" 
       newbay= Bay.where("id = ?", params[:bay][:bay_id] ).first
       newbay.cl_bay_id = params[:bay][:customer_bay_id] 
       newbay.save
       render text: newbay.bay_id 
       
#Updating class and title after dragging
 
   when "update_class"

        dragbay=Bay.where("id = ?" , params[:bay][:dragbay_id]).first
        dragbay.attribute1 = params[:bay][:dragbay_class]
        dragbay.attribute2 = params[:bay][:dragbay_title]
        dragbay.save
        dropbay=Bay.where("id = ?" , params[:bay][:dropbay_id]).first
        dropbay.attribute1 = params[:bay][:dropbay_class]
        dropbay.attribute2 = params[:bay][:dropbay_title]
        dropbay.save
             render text: 'ok'        
   end    
       
   #b= Posts.where("text = ?", params[:post][:text]).first
   
end
  
  
  
end
