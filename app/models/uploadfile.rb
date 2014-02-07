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
  
  def update_status
     self.attribute1 = ((self.no_of_error_records == 0  and self.attribute1_was=="Processed with Error") ? "Processed" : self.attribute1)
  end
  
end
