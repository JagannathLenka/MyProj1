class Bay < ActiveRecord::Base
  attr_accessible :aisle_id, :bay_id, :customer_bay_id,:noof_pos, :properties1, :properties2, :properties3, :row_aisle
end
