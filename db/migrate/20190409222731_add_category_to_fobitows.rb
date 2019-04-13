class AddCategoryToFobitows < ActiveRecord::Migration[5.0]
  def change
    add_column :fobitows, :category, :string
  end
end
