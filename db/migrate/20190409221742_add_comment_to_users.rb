class AddCommentToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :comment, :string
  end
end
