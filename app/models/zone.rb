class Zone < ActiveRecord::Base
  attr_accessible :description, :noofaisles_zone, :noofbays_aisle, :nooflevel_aisle, :properties1, :properties2, :properties3, :warehouse_id, :zone_customerid, :zone_id
end
