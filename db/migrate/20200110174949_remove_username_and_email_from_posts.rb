class RemoveUsernameAndEmailFromPosts < ActiveRecord::Migration[6.0]
  def change
    remove_column :posts, :username, :string
    remove_column :posts, :email, :string
  end
end
