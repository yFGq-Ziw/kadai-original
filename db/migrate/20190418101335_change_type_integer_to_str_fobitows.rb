class ChangeTypeIntegerToStrFobitows < ActiveRecord::Migration[5.0]
  def change
        change_column :fobitows, :likes_count, :string
  end
end
