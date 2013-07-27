class BayController < ApplicationController
  
#Dynamically arranging bays in the aisle 
 
def index
  
  @aislehash=Hash.new
  @bayhash = Hash.new
  @rowhash = Hash.new
  @bay_width = 80
  max_bay = 0
   
  aisle = Aisle.where(zone_id: params[:id])
  
  aisle.each do |aislevalue|
      @bay= Bay.where(aisle_id: aislevalue.id.to_s).order("attribute3 ASC, id ASC")
      
      
      if @bay[1].nil? 
        @rowhash   = @rowhash.merge({"aisletype" => "B"})    
        
      else
        @rowhash = @rowhash.merge({"aisletype" => aislevalue.attribute3})
        save_attribute3 = @bay[1].attribute3
      end
      bay_ctr = 0
      @bay.each do |bayvalue|

         if save_attribute3 != bayvalue.attribute3 
            @rowhash = @rowhash.merge({save_attribute3 => @bayhash})
            save_attribute3 = bayvalue.attribute3              
            @bayhash= Hash.new
            max_bay = max_bay > bay_ctr ? max_bay : bay_ctr
            bay_ctr = 0
         end
         bay_ctr = bay_ctr + 1 
         if bayvalue.cl_bay_id.blank?
            cl_bay_id = bayvalue.id
          else
            cl_bay_id = bayvalue.cl_bay_id
         end

         #customer_bay_id = bayvalue.cl_bay_id.blank? ? bayvalue.sm_bay_id : bayvalue.cl_bay_id
          
         baytype = bayvalue.attribute1.blank?  ?  "bay_Empty"  :  bayvalue.attribute1
         @bayhash= @bayhash.merge({bayvalue.id.to_s =>{:type => baytype , :item => bayvalue.attribute2, :customerid => cl_bay_id}})
   
      end
      @rowhash   = @rowhash.merge({save_attribute3 => @bayhash})
      @aislehash = @aislehash.merge(aislevalue.cl_aisle_id.blank? ? aislevalue.id : aislevalue.cl_aisle_id => @rowhash)
      max_bay = max_bay > bay_ctr ? max_bay : bay_ctr
      @rowhash = Hash.new
      @bayhash = Hash.new   
      bay_ctr = 0 
    end
    while (max_bay) * (@bay_width +2) >= 1000
       @bay_width = @bay_width - 5
    end
        @aisle_width = (max_bay) * (@bay_width +2)
end

def create
  
#Update the customer id for a bay  
   case params[:bay][:event]
      when "update_position" 
       newbay= Bay.where("id = ?", params[:bay][:bay_id] ).first
       newbay.cl_bay_id = params[:bay][:customer_bay_id] 
       newbay.save
       render text: newbay.cl_bay_id 
       
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
