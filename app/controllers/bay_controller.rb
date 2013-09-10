class BayController < ApplicationController
  
#Dynamically arranging bays in the aisle 
 
def index
  
  @aislehash=Hash.new
  @bayhash = Hash.new
  @rowhash = Hash.new
  @bay_width = 120
  max_bay = 0
   
  aisle = Aisle.where(zone_id: params[:id]).order("id ASC")
  
  
  aisle.each do |aislevalue|

  aisle_properties = {"customer_id"=> (aislevalue.cl_aisle_id.blank? ? aislevalue.sm_aisle_id: aislevalue.cl_aisle_id), "aisle_pick" => aislevalue.attribute3} 

      @bay= Bay.where(aisle_id: aislevalue.id.to_s).order("attribute3 ASC, id ASC")
      @warehouse = aislevalue.cl_warehouse_id
      @zone      = aislevalue.cl_zone_id
      
      if !@bay[1].nil? 
         save_attribute3 = @bay[1].attribute3
      end
      
      
      bay_ctr = 0
      @bay.each do |bayvalue|

         if save_attribute3 != bayvalue.attribute3 
            @rowhash = @bayhash.empty? ?  @rowhash.merge({}) : @rowhash.merge( {save_attribute3 =>  @bayhash })
            save_attribute3 = bayvalue.attribute3              
            @bayhash= Hash.new
            max_bay = max_bay > bay_ctr ? max_bay : bay_ctr
            bay_ctr = 0
         end
         
         bay_ctr = bay_ctr + 1 
         if bayvalue.cl_bay_id.blank?
            cl_bay_id = bayvalue.sm_bay_id
          else
            cl_bay_id = bayvalue.cl_bay_id
         end

         #customer_bay_id = bayvalue.cl_bay_id.blank? ? bayvalue.sm_bay_id : bayvalue.cl_bay_id
          
         baytype = bayvalue.attribute1.blank?  ?  "bay_Empty"  :  bayvalue.attribute1
         @bayhash= @bayhash.merge(bayvalue.id.to_s => {:type => baytype , :item => bayvalue.attribute2, :customerid => cl_bay_id, :priority_bay => bayvalue.attribute4})
   
      end
     
     if aislevalue.attribute3=="LR" && save_attribute3 == "R"
       @bayhash = Hash[@bayhash.sort.reverse]
     end
          @rowhash = @bayhash.empty? ?  @rowhash.merge({}) : @rowhash.merge( {save_attribute3 =>  @bayhash })
      
     
      @aislehash = @aislehash.merge( aislevalue.id.to_s => {"aisle_properties" => aisle_properties ,  "row" => @rowhash})
      max_bay = max_bay > bay_ctr ? max_bay : bay_ctr
      @rowhash = Hash.new
      @bayhash = Hash.new   
      bay_ctr = 0 
    end
    
    #render :json => @aislehash
    #Get the maximum size of the bay divider    
    while (max_bay) * (@bay_width +2) >= 1000
       @bay_width = @bay_width - 5
    end
        @aisle_width = max_bay.zero? ? 1000:(max_bay) * (@bay_width)
        
end

def create
  
#Update the customer id for a bay  
   case params[:bay][:event]
      when "update_position" 
       newbay= Bay.find_by_id(params[:bay][:bay_id].to_i)
       newbay.cl_bay_id = params[:bay][:cl_bay_id] 
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