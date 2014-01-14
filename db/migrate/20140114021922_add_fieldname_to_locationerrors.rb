class AddFieldnameToLocationerrors < ActiveRecord::Migration
  def change
    add_column :locationerrors, :uploadfile_id, :integer
  end
  
  def down
    remove_column :locationerrors, :uploadfile_id, :integer
  end
end
