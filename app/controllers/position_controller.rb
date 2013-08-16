class PositionController < ApplicationController
  def show
    #zoom functionality
    if(params[:zoom] == "yes")
       @zoom = "yes"
    else
    
    end
         
    max_pos = 0
    @pos_width = 80 
    pos_ctr = 0
    @levelhash = Hash.new
    poshash = Hash.new
    level = Level.where(:bay_id => params[:id]).order("id ASC")
    level.each do |levelvalue|
    @cl_bay_id = levelvalue.cl_bay_id
    @bay_id    = levelvalue.bay_id
    
    pos = Position.where(:level_id => levelvalue.id).order("id ASC")
   
    pos.each do |posvalue|
      postype = posvalue.attribute1.blank?   ?  "pos_Empty"  :  posvalue.attribute1
      poshash = poshash.merge({posvalue.id => {:customer_id => posvalue.cl_barcode, :type => postype, :item => posvalue.attribute2}})
      pos_ctr = pos_ctr + 1
    end
    @levelhash = @levelhash.merge({levelvalue.cl_level_id.blank? ? levelvalue.id : levelvalue.cl_level_id => poshash})
    poshash = Hash.new
    max_pos = max_pos > pos_ctr ? max_pos : pos_ctr
    pos_ctr = 0
    end
   
   while (max_pos) * (@pos_width +2) >= 800
       @pos_width = @pos_width - 5
    end
  @level_width = max_pos.zero? ? 800:(max_pos) * (@pos_width + 6)
  
  
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
