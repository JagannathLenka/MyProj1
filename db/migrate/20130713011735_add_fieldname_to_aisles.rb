class AddFieldnameToAisles < ActiveRecord::Migration
  def change
    add_column :aisles, :noof_bays, :string
  end
end
