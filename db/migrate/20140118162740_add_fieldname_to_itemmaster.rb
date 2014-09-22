class AddFieldnameToItemmaster < ActiveRecord::Migration
  def change
    add_column :itemmasters, :short_description, :string
    add_column :itemmasters, :long_description, :string
    add_column :itemmasters, :item_category1, :string
    add_column :itemmasters, :item_category2, :string
    add_column :itemmasters, :item_category3, :string
    add_column :itemmasters, :top_shelf_eligibility, :string
    add_column :itemmasters, :product_fragile, :string
    add_column :itemmasters, :unit_length, :decimal
    add_column :itemmasters, :unit_breadth, :decimal
    add_column :itemmasters, :unit_height, :decimal
    add_column :itemmasters, :unit_volume, :decimal
    add_column :itemmasters, :unit_weight, :decimal
    add_column :itemmasters, :case_length, :decimal
    add_column :itemmasters, :case_breadth, :decimal
    add_column :itemmasters, :case_height, :decimal
    add_column :itemmasters, :case_volume, :decimal
    add_column :itemmasters, :case_weight, :decimal
    add_column :itemmasters, :stocking_UOM, :string
  end
  
  def down
    remove_column :itemmasters, :short_description, :string
    remove_column :itemmasters, :long_description, :string
    remove_column :itemmasters, :item_category1, :string
    remove_column :itemmasters, :item_category2, :string
    remove_column :itemmasters, :item_category3, :string
    remove_column :itemmasters, :top_shelf_eligibility, :string
    remove_column :itemmasters, :product_fragile, :string
    remove_column :itemmasters, :unit_length, :decimal
    remove_column :itemmasters, :unit_breadth, :decimal
    remove_column :itemmasters, :unit_height, :decimal
    remove_column :itemmasters, :unit_volume, :decimal
    remove_column :itemmasters, :unit_weight, :decimal
    remove_column :itemmasters, :case_length, :decimal
    remove_column :itemmasters, :case_breadth, :decimal
    remove_column :itemmasters, :case_height, :decimal
    remove_column :itemmasters, :case_volume, :decimal
    remove_column :itemmasters, :case_weight, :decimal
    remove_column :itemmasters, :stocking_UOM, :string
  end
end
