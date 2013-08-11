class AddFieldnameToUsers < ActiveRecord::Migration
  def change
    add_column :users, :contact_phone2, :integer
    add_column :users, :attribute9, :string
    add_column :users, :attribute10, :string
    add_column :users, :attribute11, :string
    add_column :users, :attribute12, :string
    add_column :users, :attribute13, :string
    add_column :users, :attribute14, :string
    add_column :users, :attribute15, :string
    add_column :users, :attribute16, :string
    add_column :users, :attribute17, :string
    add_column :users, :attribute18, :string
    add_column :users, :attribute19, :string
    add_column :users, :attribute20, :string
  end
end
