require 'location_move'
class PositionController < ApplicationController
  
  def index
    
    if !params[:cl_bay_id].nil? and !params[:cl_warehouse_id].nil?
      bay= Bay.where('cl_warehouse_id = ?  AND cl_bay_id = ?',  params[:cl_warehouse_id], params[:cl_bay_id]).first
      render_position bay.id, params[:cl_barcode]
    end  

    if params[:cl_bay_id].nil? and !params[:cl_barcode].nil? and !params[:cl_warehouse_id].nil? 
      location = Location.where('cl_warehouse_id = ?  AND cl_barcode = ?',  params[:cl_warehouse_id], params[:cl_barcode]).first      
      bay= Bay.where('cl_warehouse_id = ?  AND cl_bay_id = ?',  params[:cl_warehouse_id], location.cl_bay_id).first
      render_position bay.id, params[:cl_barcode]
    end  

    
  end
  
  def show
      render_position params[:id], nil  
  end

  def render_position(bay_id, cl_barcode)
    
    #zoom functionality
    if(params[:item] == "Yes")
       @show_item = "Yes"
    else
    
    end
    
        
    max_pos = 0
    @pos_width = 100 
    pos_ctr = 0
    @levelhash = Hash.new
    poshash = Hash.new
    level = Level.where(:bay_id => bay_id).order("id ASC")
    level.each do |levelvalue|
    level_properties = {"customer_id" => (levelvalue.cl_level_id.blank? ? levelvalue.sm_level_id : levelvalue.cl_level_id), "priority_level" => levelvalue.attribute4}
    @cl_bay_id = levelvalue.cl_bay_id
    @bay_id    = levelvalue.bay_id
    
    pos = Position.where(:level_id => levelvalue.id).order("id ASC")
   
    pos.each do |posvalue|
      location = Location.where('cl_warehouse_id =? AND cl_barcode = ?', posvalue.cl_warehouse_id, posvalue.cl_barcode).first
      
      #If location not found in the database
      if location.nil?
        postype = "pos_Empty"
      else
        postype = location.current_quantity.to_i==0   ?  "pos_Empty"  :  "pos"  
      end
       
      poshash = poshash.merge({posvalue.id => {:customer_id => posvalue.cl_barcode, 
                                               :pos_selected => (posvalue.cl_barcode == cl_barcode ? 'yes' : 'no'),
                                               :pos_type => postype,
                                               :pos_continue => posvalue.attribute1, 
                                               :item => location.nil? ? "" :  location.current_item,
                                               :current_inventory=> location.nil? ? "" : location.current_quantity,
                                               :maximum_quantity => location.nil? ? "" : location.maximum_quantity,
                                               :minimum_quantity => location.nil? ? "" : location.minimum_quantity,
                                               :lock_code => location.nil? ? "" : location.lock_code}})
      pos_ctr = pos_ctr + 1
    end
    @levelhash = @levelhash.merge(levelvalue.id.to_s => {"level_properties" => level_properties ,  "pos" => poshash})
    poshash = Hash.new
    max_pos = max_pos > pos_ctr ? max_pos : pos_ctr
    pos_ctr = 0
    end
   
   while (max_pos) * (@pos_width +2) >= 1000
         @pos_width = @pos_width - 5
    end
    
  @level_width = max_pos.zero? ? 1000 :(max_pos) * (@pos_width + 2) 
  
  render 'show'
  
  end
  
  def create
  
   case params[:position][:event]
        
        
   #updating class and title of positions
   when "update_posclass"
       loc = LocationMovement.new
       result = loc.exchange_location(params[:position][:dragpos_id].to_i , params[:position][:droppos_id].to_i) 
   end    
       render text: result.to_s
      #b= Posts.where("text = ?", params[:post][:text]).first
   
end


end
