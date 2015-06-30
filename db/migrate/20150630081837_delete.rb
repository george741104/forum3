class Delete < ActiveRecord::Migration
  def change
    remove_column :users, :provider
    add_column :users, :token, :integer
  end
end
