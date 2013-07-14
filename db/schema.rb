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

ActiveRecord::Schema.define(:version => 20130714034619) do

  create_table "aisles", :force => true do |t|
    t.string   "aisle_id"
    t.string   "customer_aisle_id"
    t.string   "zone_id"
    t.string   "properties1"
    t.string   "properties2"
    t.string   "properties3"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.string   "noof_bays"
  end

  create_table "bays", :force => true do |t|
    t.string   "bay_id"
    t.string   "customer_bay_id"
    t.string   "aisle_id"
    t.string   "properties1"
    t.string   "properties2"
    t.string   "properties3"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.string   "row_aisle"
    t.string   "noof_pos"
  end

  create_table "levels", :force => true do |t|
    t.string   "level_id"
    t.string   "level_customerid"
    t.string   "zone_id"
    t.string   "properties1"
    t.string   "properties2"
    t.string   "properties3"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "positions", :force => true do |t|
    t.string   "pos_id"
    t.string   "bay_id"
    t.string   "level_id"
    t.string   "properties1"
    t.string   "properties2"
    t.string   "properties3"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "warehouses", :force => true do |t|
    t.string   "warehouse_id"
    t.string   "warehouse_customerid"
    t.string   "description"
    t.string   "noof_zones"
    t.string   "properties1"
    t.string   "properties2"
    t.string   "properties3"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
  end

  create_table "zones", :force => true do |t|
    t.string   "zone_id"
    t.string   "zone_customerid"
    t.string   "warehouse_id"
    t.string   "description"
    t.string   "noofaisles_zone"
    t.string   "noofbays_aisle"
    t.string   "properties1"
    t.string   "properties2"
    t.string   "properties3"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.string   "nooflevel_aisle"
  end

end
