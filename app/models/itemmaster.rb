require 'csv'
class Itemmaster < ActiveRecord::Base
  attr_accessible :attribute1, :attribute2, :attribute3, :attribute4, :attribute5, :attribute6, :attribute7, :attribute8, :case_quantity, :case_split_allowed, :client_id, :daily_avg_sales, :daily_forecast,
                  :description, :item_number, :monthly_avg_sales, :velocity, :weekly_avg_sales,
                  :short_description, :long_description, :item_category1, :item_category2, :item_category3 ,
                  :top_shelf_eligibility, :product_fragile, :unit_length, :unit_breadth, :unit_height, :unit_volume, :unit_weight,
                  :case_length, :case_breadth, :case_height, :case_volume, :case_weight, :stocking_UOM

 validates :item_number, :uniqueness => {:scope => :client_id , :allow_nil => false, :allow_blank => false,  :message => "Item number Exists"}
 
def self.upload_file uploadfile_id, file, filename
   file_uploaded = Uploadfile.find(uploadfile_id)  
   file_uploaded.attribute1 = "Processing"
   file_uploaded.save
    
   no_of_error_records = 0
   no_of_records = 0
   CSV.parse(file) do |row|
      no_of_records  += 1 
      no_of_error_records += Itemmaster.validate_process row, file, filename, uploadfile_id
      if no_of_records%100 == 0 
           file_uploaded.no_of_records = no_of_records 
           file_uploaded.no_of_error_records = no_of_error_records
           file_uploaded.no_of_processed_records =no_of_records - no_of_error_records
           file_uploaded.save
       end
   end
   
   file_uploaded.no_of_records = no_of_records
   file_uploaded.no_of_error_records = no_of_error_records
   file_uploaded.no_of_processed_records =no_of_records - no_of_error_records
   file_uploaded.attribute1 = "Processing-Done"
   file_uploaded.save
  
end

#Validate the row and process
def self.validate_process row_array, file, filename, uploadfile_id
   error = Itemmaster.is_row_valid row_array
   if error.blank?
     existitem = Itemmaster.where("client_id = ? and item_number = ? " , row_array[0] , row_array[1]).first
                 itemHash=        { :client_id => (row_array[0].to_s.encode! 'utf-8'),    
                                   :item_number =>(row_array[1].to_s.encode! 'utf-8'), 
                                   :velocity => (row_array[2].to_s.encode! 'utf-8'),
                                   :daily_avg_sales => (row_array[3].to_s.encode! 'utf-8'), 
                                   :weekly_avg_sales => (row_array[4].to_s.encode! 'utf-8'),
                                   :monthly_avg_sales => (row_array[5].to_s.encode! 'utf-8'),
                                   :daily_forecast => (row_array[6].to_s.encode! 'utf-8'),
                                   :case_quantity => (row_array[7].to_s.encode! 'utf-8'),
                                   :case_split_allowed => (row_array[8].to_s.encode! 'utf-8'),
                                   :attribute1 => (row_array[9].to_s.encode! 'utf-8'),
                                   :short_description => (row_array[10].to_s.encode! 'utf-8'),
                                   :long_description => (row_array[11].to_s.encode! 'utf-8'),                                    
                                   :item_category1 => (row_array[12].to_s.encode! 'utf-8'),
                                   :item_category2 => (row_array[13].to_s.encode! 'utf-8'),
                                   :item_category3 => (row_array[14].to_s.encode! 'utf-8'),
                                   :unit_length => (row_array[15].to_s.encode! 'utf-8').to_f,
                                   :unit_breadth => (row_array[16].to_s.encode! 'utf-8').to_f,
                                   :unit_height => (row_array[17].to_s.encode! 'utf-8').to_f,
                                   :unit_volume => (row_array[18].to_s.encode! 'utf-8').to_f,
                                   :unit_weight => (row_array[19].to_s.encode! 'utf-8').to_f,
                                   :case_length => (row_array[20].to_s.encode! 'utf-8').to_f,
                                   :case_breadth => (row_array[21].to_s.encode! 'utf-8').to_f,
                                   :case_height => (row_array[22].to_s.encode! 'utf-8').to_f,
                                   :case_volume => (row_array[23].to_s.encode! 'utf-8').to_f,
                                   :case_weight => (row_array[24].to_s.encode! 'utf-8').to_f,
                                   :stocking_UOM => (row_array[25].to_s.encode! 'utf-8')
                                }

     if existitem.nil?
          items= Itemmaster.new(itemHash)  
          items.save 
         
     else
       
       existitem.update_attributes(itemHash)   
     end
  
  else
    
     itemerror = Itemerror.new(
                                     :file_name => filename + Time.now.to_s,
                                     :uploadfile_id => uploadfile_id,
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
                                     :attribute10 => (row_array[9].to_s.encode! 'utf-8'),
                                     :attribute11 => (row_array[10].to_s.encode! 'utf-8'),
                                     :attribute12 => (row_array[11].to_s.encode! 'utf-8'),
                                     :attribute13 => (row_array[12].to_s.encode! 'utf-8'),
                                     :attribute14 => (row_array[13].to_s.encode! 'utf-8'),
                                     :attribute15 => (row_array[14].to_s.encode! 'utf-8'),
                                     :attribute16 => (row_array[15].to_s.encode! 'utf-8'),
                                     :attribute17 => (row_array[16].to_s.encode! 'utf-8'),
                                     :attribute18 => (row_array[17].to_s.encode! 'utf-8'),
                                     :attribute19 => (row_array[18].to_s.encode! 'utf-8'),
                                     :attribute20 => (row_array[19].to_s.encode! 'utf-8'),
                                     :attribute21 => (row_array[20].to_s.encode! 'utf-8'),
                                     :attribute22 => (row_array[21].to_s.encode! 'utf-8'),
                                     :attribute23 => (row_array[22].to_s.encode! 'utf-8'),
                                     :attribute24 => (row_array[23].to_s.encode! 'utf-8'),
                                     :attribute25 => (row_array[24].to_s.encode! 'utf-8'),
                                     :attribute26 => (row_array[25].to_s.encode! 'utf-8'),
                                )
            itemerror.save   
            
            return 1
     
   end
   return 0 
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
