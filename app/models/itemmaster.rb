require 'csv'
class Itemmaster < ActiveRecord::Base
  attr_accessible :attribute1, :attribute2, :attribute3, :attribute4, :attribute5, :attribute6, :attribute7, :attribute8, :case_quantity, :case_split_allowed, :client_id, :daily_avg_sales, :daily_forecast, :description, :item_number, :monthly_avg_sales, :velocity, :weekly_avg_sales

def self.upload_file file, filename
  
   CSV.parse(file) do |row|
   row_array = row
      Itemmaster.validate_process row_array, filename
   end
  
end

#Validate the row and process
def self.validate_process row_array, file
   error = Itemmaster.is_row_valid row_array
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
                                     :file_name => filename + Time.now.to_s,
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


def self.is_row_valid rowOfcsv
   
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



end
