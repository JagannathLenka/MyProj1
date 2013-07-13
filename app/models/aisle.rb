class Aisle < ActiveRecord::Base
  attr_accessible :aisle_id, :customer_aisle_id, :properties1, :properties2, :properties3, :zone_id, :noof_bays
end
