class CreateFobitows < ActiveRecord::Migration[5.0]
  def change
    create_table :fobitows do |t|
      t.text :content
      t.string :title
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end