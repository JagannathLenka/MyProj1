class WarehouseController < ApplicationController
  
def index
  
  @aislehash = { :aisle1 => {:aisleseparation => "drivepath",                           
                            :bay1 => {:type => "bay" , :item => "item1"},
                            :bay2 => {:type => "bay" , :item => "item3"},
                            :bay3 => {:type => "bay_Empty" , :item =>"item1"},
                            :bay4 => {:type => "bay_Empty" , :item =>"item6"}
                            },
                           
                :aisle2 => {:aisleseparation => "divider", 
                            :bay5 => {:type => "bay" , :item => "item1"},
                            :bay6 => {:type => "bay" , :item => "item5"},
                            :bay7 => {:type => "bay_Empty" , :item =>" item7"},
                            :bay8 => {:type => "bay_Empty" , :item =>" item1"}
                          },
                 
                 :aisle3 => {:aisleseparation => "drivepath",
                            :bay9 => {:type => "bay" , :item => "item1"},
                            :bay10 => {:type => "bay" , :item => "item5"},
                            :bay11 => {:type => "bay_Empty" , :item =>" item7"},
                            :bay12 => {:type => "bay_Empty" , :item =>" item1"}
                          },
                          
                  :aisle4 => { :aisleseparation => "divider",
                            :bay13 => {:type => "bay" , :item => "item1"},
                            :bay14 => {:type => "bay" , :item => "item5"},
                            :bay15 => {:type => "bay_Empty" , :item =>" item7"},
                            :bay16 => {:type => "bay_Empty" , :item =>" item1"}
                          },
                  :aisle5 => {:aisleseparation => "drivepath",                           
                            :bay14 => {:type => "bay" , :item => "item1"},
                            :bay15 => {:type => "bay" , :item => "item3"},
                            :bay16 => {:type => "bay_Empty" , :item =>"item1"},
                            :bay17 => {:type => "bay_Empty" , :item =>"item6"}
                            },
                           
                :aisle6 => {:aisleseparation => "divider", 
                            :bay18 => {:type => "bay" , :item => "item1"},
                            :bay19 => {:type => "bay" , :item => "item5"},
                            :bay20 => {:type => "bay_Empty" , :item =>" item7"},
                            :bay21 => {:type => "bay_Empty" , :item =>" item1"}
                          },
                 
                 :aisle7 => {:aisleseparation => "drivepath",
                            :bay22 => {:type => "bay" , :item => "item1"},
                            :bay23 => {:type => "bay" , :item => "item5"},
                            :bay24 => {:type => "bay_Empty" , :item =>" item7"},
                            :bay25 => {:type => "bay_Empty" , :item =>" item1"}
                          },
                          
                  :aisle8 => { :aisleseparation => "divider",
                            :bay26 => {:type => "bay" , :item => "item1"},
                            :bay27 => {:type => "bay" , :item => "item5"},
                            :bay28 => {:type => "bay_Empty" , :item =>" item7"},
                            :bay29 => {:type => "bay_Empty" , :item =>" item1"}
                          }
 }
 
  
end

def bay
 @id = params[:id]
 
end

end
