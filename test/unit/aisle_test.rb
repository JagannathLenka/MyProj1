require 'test_helper'

class AisleTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  
  test 'Update aisle in bay' do
    a1=Aisle.find(980190962)
    a1.cl_aisle_id = "A2"
    a1.save
    
    b1=Bay.find_by_aisle_id(980190962)
    assert_equal b1.cl_aisle_id, 'A2'
    
  end

  test 'Get rating priority' do
    a1=Aisle.find(980190962)
    rate = a1.get_rating("High")
    assert_equal rate, '09'    
  end


end

