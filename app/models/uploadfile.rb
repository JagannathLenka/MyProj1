class Uploadfile < ActiveRecord::Base
  
  after_destroy   :update_errormaintenance     #Update the locationerror and  itemerror
  before_save     :update_status, :if => :no_of_error_records_changed? 
  attr_accessible :attribute1, :attribute10, :attribute2, :attribute3, :attribute4, :attribute5, :attribute6, :attribute7, :attribute8, :attribute9, :client_id, :no_of_error_records, :no_of_processed_records, :no_of_records, :upload_filename
  
  
  #
  # updating the locationerror and  itemerror after deleting records from the upload screen
  #
  
  def update_errormaintenance 
     case self.upload_filename
       
     when 'Location.csv'
        location_error = Locationerror.destroy_all(uploadfile_id: self.id)
        
     when 'Item.csv'
         item_error = Itemerror.destroy_all(uploadfile_id: self.id)
     end 
  end
  
  #Update the status of the uploaded file
  def update_status
    
    logger.debug self.attribute1 + " " + self.no_of_processed_records.to_s + " " + self.no_of_error_records.to_s
    case

      #If the file is in processing dont change the status
      when (self.attribute1 == "Processing" or self.attribute1 == "Uploaded")
           self.attribute1 = self.attribute1
      
      #When the file has all processed record 
      when (self.no_of_processed_records !=0 and self.no_of_error_records == 0)
           self.attribute1 = "Processed" 
  
      #When the file has only error records no processed record
      when (self.no_of_processed_records ==0 and self.no_of_error_records !=0)
           self.attribute1 = "Error" 
   
      #When there are processed records and error records both in the file
      when (self.no_of_processed_records!=0 and self.no_of_error_records !=0)
           self.attribute1 = "Processed with Error" 
      #When all the records are processed and no error and no deleted records
       when (self.no_of_records == self.no_of_processed_records  and self.no_of_error_records == 0 and self.no_of_deleted_records == 0)
            self.attribute1 = "Processed Successfully"
           
    end

  end
  
end
