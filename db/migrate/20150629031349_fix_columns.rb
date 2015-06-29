class FixColumns < ActiveRecord::Migration
  def change

    remove_column :categories, :user_id
    remove_column :categories, :post_id
    remove_column :users, :post_id
    remove_column :users, :comment_id

    add_index :category_postships, :post_id
    add_index :category_postships, :category_id

    add_index :comments, :post_id
    add_index :comments, :user_id

    add_index :posts, :user_id
    add_index :user_profiles, :user_id
  end
end
