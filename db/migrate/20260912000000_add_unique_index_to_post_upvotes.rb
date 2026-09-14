class AddUniqueIndexToPostUpvotes < ActiveRecord::Migration[8.1]
  def change
    add_index :post_upvotes, [:post_id, :user_id], unique: true
  end
end