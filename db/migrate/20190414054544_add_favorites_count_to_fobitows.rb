class AddFavoritesCountToFobitows < ActiveRecord::Migration[5.0]
  def change
    add_column :fobitows, :favorites_count, :integer
  end
end
