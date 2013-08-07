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

ActiveRecord::Schema.define(:version => 20130807030356) do

  create_table "aisles", :force => true do |t|
    t.string   "client_id"
    t.integer  "sm_aisle_id"
    t.integer  "sm_zone_id"
    t.integer  "sm_warehouse_id"
    t.integer  "zone_id"
    t.string   "cl_aisle_id"
    t.string   "cl_zone_id"
    t.string   "cl_warehouse_id"
    t.string   "description"
    t.integer  "no_of_bays_aisle"
    t.integer  "no_of_levels_aisle"
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

  create_table "bays", :force => true do |t|
    t.string   "client_id"
    t.integer  "sm_bay_id"
    t.integer  "sm_aisle_id"
    t.integer  "sm_zone_id"
    t.integer  "sm_warehouse_id"
    t.integer  "aisle_id"
    t.string   "cl_bay_id"
    t.string   "cl_aisle_id"
    t.string   "cl_zone_id"
    t.string   "cl_warehouse_id"
    t.string   "description"
    t.integer  "no_of_level_bay"
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

  create_table "clients", :force => true do |t|
    t.string   "name_of_organization"
    t.integer  "address1"
    t.string   "address2"
    t.string   "zipcode"
    t.string   "state"
    t.string   "country"
    t.integer  "phone_no1"
    t.integer  "phone_no2"
    t.string   "email_id"
    t.string   "name_of_person"
    t.string   "status"
    t.string   "no_of_license_required"
    t.string   "attribute1"
    t.string   "attribute2"
    t.string   "attribute3"
    t.string   "attribute4"
    t.string   "attribute5"
    t.string   "attribute6"
    t.string   "attribute7"
    t.string   "attribute8"
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
  end

  create_table "levels", :force => true do |t|
    t.string   "client_id"
    t.integer  "sm_level_id"
    t.integer  "sm_bay_id"
    t.integer  "sm_aisle_id"
    t.integer  "sm_zone_id"
    t.integer  "sm_warehouse_id"
    t.integer  "bay_id"
    t.string   "cl_level_id"
    t.string   "cl_bay_id"
    t.string   "cl_aisle_id"
    t.string   "cl_zone_id"
    t.string   "cl_warehouse_id"
    t.string   "description"
    t.integer  "no_of_pos_level"
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
    t.string   "client_id"
    t.integer  "sm_pos_id"
    t.integer  "sm_level_id"
    t.integer  "sm_bay_id"
    t.integer  "sm_aisle_id"
    t.integer  "sm_zone_id"
    t.integer  "sm_warehouse_id"
    t.string   "sm_barcode"
    t.integer  "level_id"
    t.string   "cl_pos_id"
    t.string   "cl_level_id"
    t.string   "cl_bay_id"
    t.string   "cl_aisle_id"
    t.string   "cl_zone_id"
    t.string   "cl_warehouse_id"
    t.string   "cl_barcode"
    t.string   "description"
    t.string   "attribute1"
    t.string   "attribute2"
    t.string   "attribute3"
    t.string   "attribute4"
    t.string   "attribute5"
    t.string   "attribute6"
    t.string   "attribute7"
    t.string   "attribute8"
    t.string   "attribute9"
    t.string   "attribute10"
    t.string   "attribute11"
    t.string   "attribute12"
    t.string   "attribute13"
    t.string   "attribute14"
    t.string   "attribute15"
    t.string   "attribute16"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "client_id"
    t.integer  "contact_phone"
    t.string   "user_name"
    t.string   "user_id"
    t.string   "email_id"
    t.string   "password"
    t.string   "last_login"
    t.string   "status"
    t.string   "attribute1"
    t.string   "attribute2"
    t.string   "attribute3"
    t.string   "attribute4"
    t.string   "attribute5"
    t.string   "attribute6"
    t.string   "attribute7"
    t.string   "attribute8"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "warehouses", :force => true do |t|
    t.string   "client_id"
    t.integer  "sm_warehouse_id"
    t.string   "cl_warehouse_id"
    t.string   "description"
    t.integer  "no_of_zones"
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
    t.integer  "sm_zone_id"
    t.integer  "sm_warehouse_id"
    t.integer  "warehouse_id"
    t.string   "cl_zone_id"
    t.string   "cl_warehouse_id"
    t.string   "description"
    t.integer  "no_of_aisles_zone"
    t.integer  "no_of_bays_aisle"
    t.integer  "no_of_levels_aisle"
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
