class CreateUploadfiles < ActiveRecord::Migration
  def change
    create_table :uploadfiles do |t|
      t.string :client_id
      t.string :upload_filename
      t.integer :no_of_records
      t.integer :no_of_processed_records
      t.integer :no_of_error_records
      t.string :attribute1
      t.string :attribute2
      t.string :attribute3
      t.string :attribute4
      t.string :attribute5
      t.string :attribute6
      t.string :attribute7
      t.string :attribute8
      t.string :attribute9
      t.string :attribute10

      t.timestamps
    end
  end
end
