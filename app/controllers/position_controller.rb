class PositionController < ApplicationController
  def show
    #zoom functionality
    if(params[:zoom] == "yes")
       @zoom = "yes"
     else
       
     end   
  
  @levelhash = Hash.new
  poshash = Hash.new
  level = Level.where(:bay_id => params[:id])
  level.each do |levelvalue|
    @cl_bay_id = levelvalue.cl_bay_id
    @bay_id    = levelvalue.bay_id
    
    pos = Position.where(:level_id => levelvalue.id)
    pos.each do |posvalue|
      postype = posvalue.attribute1.blank?  ?  "pos_Empty"  :  posvalue.attribute1
      poshash = poshash.merge({posvalue.id => {:type => postype, :item => posvalue.attribute2}})
    end
    @levelhash = @levelhash.merge({levelvalue.cl_level_id.blank? ? levelvalue.id : levelvalue.cl_level_id => poshash})
    poshash = Hash.new
  end
  
  
  
    end
  
  def create
  
   case params[:position][:event]
        
        
 #updating class and title of positions
   when "update_posclass"
        dragpos=Position.find_by_id(params[:position][:dragpos_id].to_i)
        dragpos.attribute1 = params[:position][:dragpos_class]
        dragpos.attribute2 = params[:position][:dragpos_title]
        dragpos.save
        
        droppos=Position.find_by_id(params[:position][:droppos_id].to_i)
        droppos.attribute1 = params[:position][:droppos_class]
        droppos.attribute2 = params[:position][:droppos_title]
        droppos.save      
   end    
       render text: "ok"
   #b= Posts.where("text = ?", params[:post][:text]).first
   
end


end
