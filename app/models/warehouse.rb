class Warehouse < ActiveRecord::Base
  attr_accessible :description, :noof_zones, :properties1, :properties2, :properties3, :warehouse_customerid, :warehouse_id
end
