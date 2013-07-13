class AddFieldnameToBays < ActiveRecord::Migration
  def change
    add_column :bays, :row_aisle, :string
    add_column :bays, :noof_pos, :string
  end
end
