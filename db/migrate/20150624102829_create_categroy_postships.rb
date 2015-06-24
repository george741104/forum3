class CreateCategroyPostships < ActiveRecord::Migration
  def change
    create_table :categroy_postships do |t|
      t.integer :post_id
      t.integer :category_id

      t.timestamps null: false
    end
  end
end
