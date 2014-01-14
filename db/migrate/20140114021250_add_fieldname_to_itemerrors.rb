class AddFieldnameToItemerrors < ActiveRecord::Migration
  def change
    add_column :itemerrors, :uploadfile_id, :integer
  end
  
  def down
    remove_column :itemerrors, :uploadfile_id, :integer
  end
end
