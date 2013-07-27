class AddFieldnameToAisles < ActiveRecord::Migration
  def change
    add_column :aisles, :no_of_levels_aisles, :string
  end
end
