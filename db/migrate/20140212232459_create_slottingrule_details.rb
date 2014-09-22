class CreateSlottingruleDetails < ActiveRecord::Migration
  def change
    create_table :slottingrule_details do |t|
      t.integer :rule_id
      t.string :rule_type
      t.string :rule_description
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
      t.string :attribute11
      t.string :attribute12

      t.timestamps
    end
  end
end
