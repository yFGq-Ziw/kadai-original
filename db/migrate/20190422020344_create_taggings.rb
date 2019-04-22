class CreateTaggings < ActiveRecord::Migration[5.0]
  def change
    create_table :taggings do |t|
      t.integer :tag_id
      t.integer :fobitow_id

      t.timestamps null: false
    end
    add_index :taggings, :tag_id
    add_index :taggings, [:tag_id, :fobitow_id], unique: true
  end
end
