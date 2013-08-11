class AddFieldnameToClients < ActiveRecord::Migration
  def change
    add_column :clients, :lastname_of_person, :string
  end
end
