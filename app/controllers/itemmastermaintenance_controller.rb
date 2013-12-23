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
   file = params[:file].read
   CSV.parse(file) do |row|
   row_array = row
   
   error = is_row_valid row_array
   if error.blank?
     existitem = Itemmaster.where("client_id = ? and item_number = ? " , row_array[0] , row_array[1]).first
     if existitem.nil?
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
                                   :attribute1 => (row_array[9].to_s.encode! 'utf-8')
                                   
                               )  
        
         items.save 
         
     else
       
       existitem.update_attributes({
                                   :client_id => (row_array[0].to_s.encode! 'utf-8'),    
                                   :item_number =>(row_array[1].to_s.encode! 'utf-8'), 
                                   :velocity => (row_array[2].to_s.encode! 'utf-8'),
                                   :daily_avg_sales => (row_array[3].to_s.encode! 'utf-8'), 
                                   :weekly_avg_sales => (row_array[4].to_s.encode! 'utf-8'),
                                   :monthly_avg_sales => (row_array[5].to_s.encode! 'utf-8'),
                                   :daily_forecast => (row_array[6].to_s.encode! 'utf-8'),
                                   :case_quantity => (row_array[7].to_s.encode! 'utf-8'),
                                   :case_split_allowed => (row_array[8].to_s.encode! 'utf-8'),
                                   :attribute1 => (row_array[9].to_s.encode! 'utf-8')
                                           
                                  
                                  }) 
     
     end
  
  else
    
     itemerror = Itemerror.new(
                                     :file_name => params[:file].original_filename + Time.now.to_s,
                                     :error_description => error,
                                     :attribute1 => (row_array[0].to_s.encode! 'utf-8'),
                                     :attribute2 => (row_array[1].to_s.encode! 'utf-8'), 
                                     :attribute3 => (row_array[2].to_s.encode! 'utf-8'),
                                     :attribute4 => (row_array[3].to_s.encode! 'utf-8'),
                                     :attribute5 => (row_array[4].to_s.encode! 'utf-8'),
                                     :attribute6 => (row_array[5].to_s.encode! 'utf-8'),
                                     :attribute7 => (row_array[6].to_s.encode! 'utf-8'),
                                     :attribute8 => (row_array[7].to_s.encode! 'utf-8'),
                                     :attribute9 => (row_array[8].to_s.encode! 'utf-8'),
                                     :attribute10 => (row_array[9].to_s.encode! 'utf-8')
                           
                                )
            itemerror.save   
     
   end
 
  end
    redirect_to :back 
end


def is_row_valid rowOfcsv
   
   error = ""
   #client shouldnt be blank
   if client = User.where(client_id: rowOfcsv[0]).first.nil?
     error = "ClientId not found"
     
   end  
   #Item should not be blank
   if rowOfcsv[1].blank?
    error += (error.blank? ? "" : ",") + "Item not found"
      
   end
   
     return error
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
