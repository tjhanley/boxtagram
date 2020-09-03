class AddDropboxColumsToUser < ActiveRecord::Migration
  def change
    add_column :users, :dropbox_secret_token, :string
  end
end
