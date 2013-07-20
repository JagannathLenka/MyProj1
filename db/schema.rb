# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130720174413) do

  create_table "aisles", :force => true do |t|
    t.string   "client_id"
    t.string   "sm_aisle_id"
    t.string   "sm_zone_id"
    t.string   "sm_warehouse_id"
    t.string   "zone_id"
    t.string   "cl_aisle_id"
    t.string   "cl_zone_id"
    t.string   "cl_warehouse_id"
    t.string   "description"
    t.string   "no_of_bays_aisle"
    t.string   "attribute1"
    t.string   "attribute2"
    t.string   "attribute3"
    t.string   "attribute4"
    t.string   "attribute5"
    t.string   "attribute6"
    t.string   "attribute7"
    t.string   "attribute8"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "bays", :force => true do |t|
    t.string   "client_id"
    t.string   "sm_bay_id"
    t.string   "sm_aisle_id"
    t.string   "sm_zone_id"
    t.string   "sm_warehouse_id"
    t.string   "aisle_id"
    t.string   "cl_bay_id"
    t.string   "cl_aisle_id"
    t.string   "cl_zone_id"
    t.string   "cl_warehouse_id"
    t.string   "description"
    t.string   "no_of_level_bay"
    t.string   "attribute1"
    t.string   "attribute2"
    t.string   "attribute3"
    t.string   "attribute4"
    t.string   "attribute5"
    t.string   "attribute6"
    t.string   "attribute7"
    t.string   "attribute8"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "levels", :force => true do |t|
    t.string   "client_id"
    t.string   "sm_level_id"
    t.string   "sm_bay_id"
    t.string   "sm_aisle_id"
    t.string   "sm_zone_id"
    t.string   "sm_warehouse_id"
    t.string   "bay_id"
    t.string   "cl_level_id"
    t.string   "cl_bay_id"
    t.string   "cl_aisle_id"
    t.string   "cl_zone_id"
    t.string   "cl_warehouse_id"
    t.string   "description"
    t.string   "no_of_pos_level"
    t.string   "attribute1"
    t.string   "attribute2"
    t.string   "attribute3"
    t.string   "attribute4"
    t.string   "attribute5"
    t.string   "attribute6"
    t.string   "attribute7"
    t.string   "attribute8"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "positions", :force => true do |t|
    t.string   "pos_id"
    t.string   "pos_customerid"
    t.string   "bay_id"
    t.string   "level_id"
    t.string   "properties1"
    t.string   "properties2"
    t.string   "properties3"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "warehouses", :force => true do |t|
    t.string   "client_id"
    t.string   "sm_warehouse_id"
    t.string   "cl_warehouse_id"
    t.string   "description"
    t.string   "no_of_zones"
    t.string   "attribute1"
    t.string   "attribute2"
    t.string   "attribute3"
    t.string   "attribute4"
    t.string   "attribute5"
    t.string   "attribute6"
    t.string   "attribute7"
    t.string   "attribute8"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "zones", :force => true do |t|
    t.string   "client_id"
    t.string   "sm_zone_id"
    t.string   "sm_warehouse_id"
    t.string   "warehouse_id"
    t.string   "cl_zone_id"
    t.string   "cl_warehouse_id"
    t.string   "description"
    t.string   "no_of_aisles_zone"
    t.string   "no_of_bays_aisle"
    t.string   "no_of_levels_aisle"
    t.string   "attribute1"
    t.string   "attribute2"
    t.string   "attribute3"
    t.string   "attribute4"
    t.string   "attribute5"
    t.string   "attribute6"
    t.string   "attribute7"
    t.string   "attribute8"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

end
