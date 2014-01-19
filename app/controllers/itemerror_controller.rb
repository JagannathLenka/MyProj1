class ItemerrorController < ApplicationController
  
    # GET /maintenance
  def index
    
 
   columns =  ['id','file_name', 'transaction_id','sequence_no','error_code', 'error_description', 'attribute1','attribute2','attribute3','attribute4','attribute5','attribute6','attribute7','attribute8','attribute9','attribute10']
   itemerror = Itemerror.select(" id ,file_name , transaction_id ,sequence_no , error_code , error_description ,  attribute1 , attribute2 , attribute3 , attribute4, attribute5, attribute6 , attribute7 , attribute8 , attribute9 , attribute10 ")
   .where(get_searchstring).paginate(
      :page     => params[:page],
      :per_page => params[:rows],
      :order    => order_by_from_params(params))
  
    if request.xhr? 
    render :json => json_for_jqgrid(itemerror, columns)
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
     
       if !params[:uploadfile_id].nil?
        search_string = "uploadfile_id =" +  params[:uploadfile_id]
     end
     
     return search_string
  end
  
 def create
  
   case params[:oper]
   when "edit" 
       
       itemerror = Itemerror.find_by_id(params[:id])
       itemerror.update_attributes({
                                           :attribute1 => params[:attribute1],
                                           :attribute2 => params[:attribute2], 
                                           :attribute3 => params[:attribute3],
                                           :attribute4 => params[:attribute4],
                                           :attribute5 => params[:attribute5],
                                           :attribute6 => params[:attribute6],
                                           :attribute7 => params[:attribute7],
                                           :attribute8 => params[:attribute8],
                                           :attribute9 => params[:attribute9],
                                           :attribute10 => params[:attribute10]
                                       })
                                       
    when "del"  
 
       params[:id].split(',').each do |id|
          Itemerror.destroy(id.to_i)
       end
       
    when "proc"
       
       reprocess                                  
      
   end
   
   
    if request.xhr?
       render :json => itemerror
    end
  end
  
  #reprocessing the error in locationerror
  def reprocess
   ids = params[:id]
   ids.each do |id|
   itemerror = Itemerror.find(id.to_i)
   error =  is_row_valid itemerror 
   if error.blank?
     
     itemHash = {:client_id => itemerror.attribute1,    
                                   :item_number => itemerror.attribute2, 
                                   :velocity => itemerror.attribute3,
                                   :daily_avg_sales =>itemerror.attribute4, 
                                   :weekly_avg_sales => itemerror.attribute5,
                                   :monthly_avg_sales => itemerror.attribute6,
                                   :daily_forecast => itemerror.attribute7,
                                   :case_quantity => itemerror.attribute8,
                                   :case_split_allowed => itemerror.attribute9,
                                   :attribute1 => itemerror.attribute10,
                                   :short_description => itemerror.attribute11,
                                   :long_description => itemerror.attribute12,                                    
                                   :item_category1 => itemerror.attribute13,
                                   :item_category2 => itemerror.attribute14,
                                   :item_category3 => itemerror.attribute15,
                                   :unit_length => itemerror.attribute16,
                                   :unit_breadth => itemerror.attribute17,
                                   :unit_height => itemerror.attribute18,
                                   :unit_volume => itemerror.attribute19,
                                   :unit_weight => itemerror.attribute20,
                                   :case_length => itemerror.attribute21,
                                   :case_breadth => itemerror.attribute22,
                                   :case_height => itemerror.attribute23,
                                   :case_volume => itemerror.attribute24,
                                   :case_weight => itemerror.attribute25,
                                   :stocking_UOM => itemerror.attribute26
                                   }
                                   
                                   
   existitem = Itemmaster.where("client_id = ? and item_number = ? " , itemerror.attribute1 , itemerror.attribute2).first
     if existitem.nil?
          items= Itemmaster.new(itemHash)
                           
         items.save 
        
       else
        existitem.update_attributes(itemHash)                               
       end
       
       Itemerror.destroy(id.to_i) 
        
      else

          itemerror.update_attributes({
                                          
                                      :error_description => error
                                       
                                   })
       end
  end 
   
 end
 def is_row_valid itemerror
   
   error = ""
   #client shouldnt be blank
   if client = User.where(client_id: itemerror.attribute1).first.nil?
     error = "ClientId not found"
     
   end  
   #Item should not be blank
   if itemerror.attribute2.blank?
     error += (error.blank? ? "" : ",") + "Item not found"
      
   end
    
     return error
   end
 

end
