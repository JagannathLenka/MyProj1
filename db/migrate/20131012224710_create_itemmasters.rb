class CreateItemmasters < ActiveRecord::Migration
  def up
    create_table :itemmasters do |t|
      t.string   "client_id"
      t.string   "item_number"
      t.string   "description"
      t.string   "velocity"
      t.integer  "case_quantity"
      t.string   "case_split_allowed"
      t.integer  "daily_avg_sales"
      t.integer  "weekly_avg_sales"
      t.integer  "monthly_avg_sales"
      t.string   "daily_forecast"
      t.string   "attribute1"
      t.string   "attribute2"
      t.string   "attribute3"
      t.string   "attribute4"
      t.string   "attribute5"
      t.string   "attribute6"
      t.string   "attribute7"
      t.string   "attribute8"

      t.timestamps
    end
  end
  
  def down
    drop_table :itemmasters
  end
end
