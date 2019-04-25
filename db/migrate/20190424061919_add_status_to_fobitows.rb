class AddStatusToFobitows < ActiveRecord::Migration[5.0]
  def change
    add_column :fobitows, :status, :integer, default: 1, null: false, limit: 1
  end
end
