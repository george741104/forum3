class CreateFavorites < ActiveRecord::Migration
  def change
    create_table :favorites do |t|
      t.integer :post_id
      t.integer :user_id

      t.timestamps null: false
    end
    add_index :favorites, :post_id
    add_index :favorites, :user_id
  end
end
