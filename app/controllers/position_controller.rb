class PositionController < ApplicationController
  def show
    #zoom functionality
    if(params[:zoom] == "yes")
       @zoom = "yes"
     else
       
     end   
#dynamically arranging position and level of the item in the  bay
  
    id = Level.where("level_id = ?", params[:id]).first
    if id.customer_bay_id == ""
      @customer_bay_id = id.bay_id
    else
      @customer_bay_id = id.customer_bay_id
    end
    @level_id =id.level_id
    
    @levelhash=Hash.new
    level = Level.where(bay_id: params[:id])
    level.each do |levelvalue|
      pos = Position.where("level_id = ? AND bay_id = ?", levelvalue.level_id, params[:id])
      poshash=Hash.new
      poshash= poshash.merge({:leveltype => levelvalue.properties1})
      pos.each do |posvalue|
        poshash = poshash.merge({posvalue.pos_id => {:postype => posvalue.properties1 , :item => posvalue.properties2}})
        
      end
      @levelhash = @levelhash.merge(levelvalue.level_id  => poshash)
    
    end
  
  end
  
  def create
  
   case params[:position][:event]
        
        
 #updating class and title of positions
   when "update_posclass"
        dragpos=Position.where("pos_id = ? AND bay_id = ?" , params[:position][:dragpos_id] , params[:position][:bay_id]).first
        dragpos.properties1 = params[:position][:dragpos_class]
        dragpos.properties2 = params[:position][:dragpos_title]
        dragpos.save
        
        droppos=Position.where("pos_id = ? AND bay_id = ?" , params[:position][:droppos_id] , params[:position][:bay_id]).first
        droppos.properties1 = params[:position][:droppos_class]
        droppos.properties2 = params[:position][:droppos_title]
        droppos.save      
   end    
       render text: "ok"
   #b= Posts.where("text = ?", params[:post][:text]).first
   
end


end
