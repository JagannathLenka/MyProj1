require 'csv'
class ItemmastermaintenanceController < ApplicationController
  
 # GET /Render the JQGrid for slotting recomendation
  def index

     get_header_details  if !request.xhr?
     columns =  ['id', 'item_number', 'velocity','daily_avg_sales','weekly_avg_sales',
       'monthly_avg_sales','daily_forecast','case_quantity','case_split_allowed','attribute1','attribute2']
      items = Itemmaster.select("*").paginate(
                     :page     => params[:page],
                     :per_page => params[:rows],
                     :order    => order_by_from_params(params))

      
      
     if request.xhr? 
       render :json => json_for_jqgrid(items, columns)
     end

  end
  
  def upload
   file = params[:file].read
   CSV.parse(file) do |row|
   row_array = row
   
    items= Itemmaster.new(
                                   :client_id => (row_array[0].to_s.encode! 'utf-8'),    
                                   :item_number =>(row_array[1].to_s.encode! 'utf-8'), 
                                   :velocity => (row_array[2].to_s.encode! 'utf-8'),
                                   :daily_avg_sales => (row_array[3].to_s.encode! 'utf-8'), 
                                   :weekly_avg_sales => (row_array[4].to_s.encode! 'utf-8'),
                                   :monthly_avg_sales => (row_array[5].to_s.encode! 'utf-8'),
                                   :daily_forecast => (row_array[6].to_s.encode! 'utf-8'),
                                   :case_quantity => (row_array[7].to_s.encode! 'utf-8'),
                                   :case_split_allowed => (row_array[8].to_s.encode! 'utf-8'),
                                   :attribute1 => (row_array[9].to_s.encode! 'utf-8'),
                                   :attribute2 => (row_array[10].to_s.encode! 'utf-8'),
                                   :attribute3 => (row_array[11].to_s.encode! 'utf-8'),
                                   :attribute4 => (row_array[12].to_s.encode! 'utf-8')
                               )  
        
         items.save 
   
 
  end
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
              Itemmaster.destroy(params[:id].to_i)   
             
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
