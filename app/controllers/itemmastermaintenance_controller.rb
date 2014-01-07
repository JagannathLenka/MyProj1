require 'csv'
class ItemmastermaintenanceController < ApplicationController
  
 # GET /Render the JQGrid for slotting recomendation
  def index

     get_header_details  if !request.xhr?
     columns =  ['id', 'item_number', 'velocity','daily_avg_sales','weekly_avg_sales',
       'monthly_avg_sales','daily_forecast','case_quantity','case_split_allowed','attribute1','attribute2']
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
  
  def upload
   file= params[:file].read
   Itemmaster.delay.upload_file file
   redirect_to :back 
  end



 
 #Update the aisles and create bays and levels beased on the input from JQgrid
 def create
  
  @error = ""
  case params[:oper]
  when "edit"
       edit_item_master 
                
  when "add"
        items= Itemmaster.new(
                                   :client_id => cookies[:client_id],
                                   :item_number => params[:item_number], 
                                   :velocity => params[:velocity],
                                   :daily_avg_sales => params[:daily_avg_sales],   
                                   :weekly_avg_sales => params[:weekly_avg_sales],
                                   :monthly_avg_sales => params[:monthly_avg_sales],
                                   :daily_forecast => params[:daily_forecast],
                                   :case_quantity => params[:case_quantity],
                                   :case_split_allowed => params[:case_split_allowed],
                                   :attribute1 => params[:attribute1]
                               )  
        
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
         items.update_attributes({ 
                                   :item_number => params[:item_number], 
                                   :velocity => params[:velocity],
                                   :daily_avg_sales => params[:daily_avg_sales],   
                                   :weekly_avg_sales => params[:weekly_avg_sales],
                                   :monthly_avg_sales => params[:monthly_avg_sales],
                                   :daily_forecast => params[:daily_forecast],
                                   :case_quantity => params[:case_quantity],
                                   :case_split_allowed => params[:case_split_allowed],
                                   :attribute1 => params[:attribute1]
                                  
                             
                                  })
                                  
 end
  
  

 #Write the breadcrumbs
 def get_header_details
   
    
 end 

    
end
