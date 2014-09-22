require 'test_helper'

class AislemaintenanceControllerTest < ActionController::TestCase
  # test "the truth" do
  #   assert true
  # end
  
  test "Add Aisles" do
      
      post :create,  {"sm_aisle_id"=>"", "cl_aisle_id"=>"A31", "description"=>"", "client_id"=>"", "no_of_bays_aisle"=>"6", "no_of_bays_aisle_hidden"=>"", "no_of_levels_aisle"=>"6", "no_of_levels_aisle_hidden"=>"", "attribute3"=>"LR", "attribute4"=>"Default", "attribute1"=>"", "attribute2"=>"", "attribute5"=>"", "attribute6"=>"", "attribute7"=>"", "attribute8"=>"", "pt_zone_id"=>zone.id.to_s, "oper"=>"add", "id"=>"_empty", :format => 'json'}
      #post :create, {:format => 'json', "sm_aisle_id"=>"15", "cl_aisle_id"=>"A15", "description"=>"", "client_id"=>"", "no_of_bays_aisle"=>"6", "no_of_bays_aisle_hidden"=>"0", "no_of_levels_aisle"=>"6", "no_of_levels_aisle_hidden"=>"", "attribute3"=>"LR", "attribute4"=>"Default", "attribute1"=>"015", "attribute2"=>"", "attribute5"=>"", "attribute6"=>"", "attribute7"=>"", "attribute8"=>"", "oper"=>"add", "id"=>"483"}
      
      bays =  Bay.where(:cl_aisle_id => "A31")
      assert_equal 6 , bay_count
 end

  test "Update Aisles" do
      
     post :create,  {"sm_aisle_id"=>"", "cl_aisle_id"=>"A31", "description"=>"", "client_id"=>"", "no_of_bays_aisle"=>"6", "no_of_bays_aisle_hidden"=>"", "no_of_levels_aisle"=>"6", "no_of_levels_aisle_hidden"=>"", "attribute3"=>"LR", "attribute4"=>"Default", "attribute1"=>"", "attribute2"=>"", "attribute5"=>"", "attribute6"=>"", "attribute7"=>"", "attribute8"=>"", "pt_zone_id"=>zone.id.to_s, "oper"=>"add", "id"=>"_empty", :format => 'json'}
     aisle = JSON.parse(@response.body)
     
     post :create,  {"sm_aisle_id"=>aisle.sm_aisle_id, "cl_aisle_id"=>"A31", "description"=>"", "client_id"=>"", "no_of_bays_aisle"=>"6", "no_of_bays_aisle_hidden"=>"0", "no_of_levels_aisle"=>"6", "no_of_levels_aisle_hidden"=>"", "attribute3"=>"LR", "attribute4"=>"Default", "attribute1"=>"015", "attribute2"=>"", "attribute5"=>"", "attribute6"=>"", "attribute7"=>"", "attribute8"=>"", "oper"=>"edit", "id"=>aisle.id, :format => 'json'}
      
      bays =  Bay.where(:cl_aisle_id => "A31")
      assert_equal 6 , bay_count
 end

 
end

