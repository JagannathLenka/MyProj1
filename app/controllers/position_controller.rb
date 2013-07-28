class PositionController < ApplicationController
  def show
    #zoom functionality
    if(params[:zoom] == "yes")
       @zoom = "yes"
     else
       
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
