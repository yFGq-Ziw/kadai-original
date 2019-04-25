class CreateForums < ActiveRecord::Migration[5.0]
  def change
    create_table :forums do |t|
      t.references :user, foreign_key: true
      t.references :fobitow, foreign_key: true

      t.timestamps

      t.index [:user_id, :fobitow_id], unique: true
      t.string :content
    end
  end
end
