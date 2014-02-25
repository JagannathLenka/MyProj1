class SlottingruleMastermaintenanceController < ApplicationController
  
   def index

     get_header_details  if !request.xhr?
     columns =  ['id', 'priority','description', 'status', 'users','attribute1','attribute2','attribute3','attribute4','attribute5','attribute6']
      slottingrule_master = SlottingruleMaster.select("*")
                     .paginate(
                     :page     => params[:page],
                     :per_page => params[:rows],
                     :order    => order_by_from_params(params))

      
      
     if request.xhr? 
       render :json => json_for_jqgrid(slottingrule_master, columns)
     end

  end
  
  
  
  def create
    
    case params[:oper]
    
        when "edit"
          
         slottingrule_master = SlottingruleMaster.find_by_id(params[:id])
         slottingrule_master.update_attributes(params[:SlottingruleMaster])
           @error = params[:SlottingruleMaster][:priority] + ' ' + slottingrule_master.errors.values[0][0] if slottingrule_master.errors.count > 0 
                      
          
             
        when "add"
          
                  
           slottingrule_master = SlottingruleMaster.new(params[:SlottingruleMaster])  
                                           
           slottingrule_master.save                                   
           @error = params[:SlottingruleMaster][:priority] + ' ' + slottingrule_master.errors.values[0][0] if slottingrule_master.errors.count > 0  
        
        #Add a slotting wave to slotting wave master for the given rule selected   
        when "add_slott_wave"
          slotting_waves = SlottingWave.new(
                                            {client_id: cookies[:client_id],
                                             preffered_slotting_rules: params[:rule_id],
                                             wave_status: "Open" ,
                                             wave_number: "Wave" + Time.now().to_s 
                                            }) 
                            
            slotting_waves.save
                 
        when "del"
          
              params[:id].split(',').each do |id|
                  SlottingruleMaster.destroy(id.to_i)
              
              end 
        end
    
     
     if request.xhr?
       if !@error.blank?        
        render :json => @error.to_json, status: 500
       else
      render :json => nil
    end
   end 
   
  end
  
  
 #Write the breadcrumbs
 def get_header_details
   
    
 end 

end
