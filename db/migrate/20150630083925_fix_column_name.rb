class FixColumnName < ActiveRecord::Migration
  def change
    rename_column :users, :uid, :fb_uid
    rename_column :users, :token, :fb_token
  end
end
