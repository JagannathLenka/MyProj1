require 'test_helper'

class ItemMasterTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  
   test "Check the validity of the row" do
        
    row_array = ['CL4', '123456', 'A', '10', '20', '100','10','Yes','FREEZER']
    error = Itemmaster.is_row_valid row_array
    assert_equal "ClientId not found", error  
    
    row_array = ['CL1', '', 'A', '10', '20', '100','10','Yes','FREEZER']
    error = Itemmaster.is_row_valid row_array
    assert_equal "Item not found",  error  

    row_array = ['CL4', '', 'A', '10', '20', '100','10','Yes','FREEZER']
    error = Itemmaster.is_row_valid row_array
    assert_equal "ClientId not found,Item not found", error  

    
  end
  
  test "ClientId not found added to error file" do    
    file = Files.new
    row_array = ['CL4', '1234567', 'A', '10', '20', '100','10','Yes','FREEZER']
    Itemmaster.validate_process row_array, file
    error = Itemerror.find_by_attribute1('CL4')
    assert_equal "ClientId not found", error.error_description 
 end            

 test "ClientId and Item not found added to error file" do 
    file = Files.new
    row_array = ['CL4', '', 'A', '10', '20', '100','10','Yes','FREEZER']
    Itemmaster.validate_process row_array, file
    error = Itemerror.find_by_attribute1('CL4')
    assert_equal "ClientId not found,Item not found", error.error_description 
end

 test "Item not found added to error file" do 
    file = Files.new
    row_array = ['CL1', '', 'A', '10', '20', '100','10','Yes','FREEZER']
    Itemmaster.validate_process row_array, file
    error = Itemerror.find_by_attribute1('CL1')
    assert_equal "Item not found",   error.error_description
 end
  
test "Item not written to the Item error file" do    
    file = Files.new
    row_array = ['CL1', '1234567', 'A', '10', '20', '100','10','Yes','FREEZER']
    Itemmaster.validate_process row_array, file
    error = Itemerror.find_by_attribute1_and_attribute2('CL1', '1234567')
    assert_equal true, error.nil? 
end

test "Item written to the Item master file" do       
    file = Files.new
    row_array = ['CL1', '1234567', 'A', '10', '20', '100','10','Yes','FREEZER']
    Itemmaster.validate_process row_array, file
    item = Itemmaster.find_by_client_id_and_item_number('CL1', '1234567')
    assert_equal false, item.nil?
 end            


end

class Files 
 def original_filename
   "testfile.csv"
 end
  
end