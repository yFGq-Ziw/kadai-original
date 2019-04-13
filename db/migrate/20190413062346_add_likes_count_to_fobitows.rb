class AddLikesCountToFobitows < ActiveRecord::Migration[5.0]
  def change
    add_column :fobitows, :likes_count, :integer
  end
end
