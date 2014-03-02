class SlottingruleDetailsmaintenanceController < ApplicationController
  
  def index

     get_header_details  if !request.xhr?
     columns =  ['id', 'rule_id','rule_type', 'rule_description','attribute1','attribute2','attribute3','attribute4','attribute5','attribute6']
      slottingrule_details = SlottingruleDetails.select("*").where(rule_id: params[:id])
                     .paginate(
                     :page     => params[:page],
                     :per_page => params[:rows],
                     :order    => order_by_from_params(params))

      
      
      if request.xhr? 
             if params[:oper]=='subselect'
                  item_category = Itemmaster.find_by_sql('select distinct ' + params[:val] + ' from itemmasters where ' + params[:val] + ' not NULL and ' + params[:val] + ' !=""')
                  render :json => item_category.to_json
             else

                 render :json => json_for_jqgrid(slottingrule_details, columns)
                 
             end
         end

  end
  
  
  
  def create
    
    case params[:oper]
    
        when "edit"
          slottingrule_details = SlottingruleDetails.find_by_id(params[:id])
          slottingrule_details.update_attributes(params[:SlottingruleDetails])
          
             
        when "add"
           slottingrule_master = SlottingruleMaster.find_by_id(params[:pt_master_id])
                    
           slottingrule_details = SlottingruleDetails.new(params[:SlottingruleDetails]) 
           slottingrule_details.rule_id = params[:pt_master_id]
           slottingrule_details.save 
            
        
        when "del"
          
              params[:id].split(',').each do |id|
              SlottingruleDetails.destroy(id.to_i)
          end 
          
        end
    
    if request.xhr?
           render :json => nil 
    end    
   
  end
  
  
 #Write the breadcrumbs
 def get_header_details
   add_breadcrumb "Rules Master" ,  "/slottingrule_mastermaintenance"
 end 
 
end
