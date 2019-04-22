class CreateFobitowhashtags < ActiveRecord::Migration[5.0]
  def change
    create_table :fobitowhashtags, id: false do |t|
      t.references :fobitow, foreign_key: true
      t.references :tag, foreign_key: true

      t.index [:fobitow_id, :tag_id], unique: true
    end
  end
end