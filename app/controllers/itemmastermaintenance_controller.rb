require 'csv'
class ItemmastermaintenanceController < ApplicationController
  
 # GET /Render the JQGrid for slotting recomendation
  def index

     get_header_details  if !request.xhr?
     columns =  ['id', 'item_number', 'long_description', 'short_description', 'velocity','daily_avg_sales','weekly_avg_sales',
                 'monthly_avg_sales', 'item_category1', 'item_category2', 'item_category3', 'unit_length', 'unit_breadth', 'unit_height', 'unit_volume', 'unit_weight',
                 'case_length', 'case_breadth', 'case_height', 'case_volume' , 'case_weight','stocking_UOM' ,
                 'daily_forecast','case_quantity','case_split_allowed','attribute1']
      items = Itemmaster.select("*")
                     .where(get_searchstring )
                     .paginate(
                     :page     => params[:page],
                     :per_page => params[:rows],
                     :order    => order_by_from_params(params))

      
      
     if request.xhr? 
       render :json => json_for_jqgrid(items, columns)
     end

  end
  
   def get_searchstring 
     search_string = '1 = 1'
     if params[:_search] == "true"
      case params[:searchOper]
      when 'eq'
        search_string = params[:searchField] + " = '" +  params[:searchString] + "'"
      when 'bw'
        search_string = params[:searchField] + " like '" +  params[:searchString] + "%'"
      end 
     end
     return search_string
  end
  

 
 #Update the aisles and create bays and levels beased on the input from JQgrid
 def create
  
  @error = ""
  case params[:oper]
  when "edit"
       edit_item_master 
                
  when "add"
        items= Itemmaster.new(params[:itemmaster])  
        items.save 
         
       
  when "del"
              params[:id].split(',').each do |id|
                 Itemmaster.destroy(id.to_i) 
              end
                
             
 end        
    #If it is a Ajax then send the json details
    
    if request.xhr?
       if !@error.blank?        
        render :json => @error.to_json, status: 500
       else
      render :json => items
    end
   end 
 end
 
 
 def edit_item_master
 
         items = Itemmaster.find_by_id(params[:id])  
         items.update_attributes(params[:itemmaster])
                                  
 end

 #Write the breadcrumbs
 def get_header_details
   
    
 end 

    
end
