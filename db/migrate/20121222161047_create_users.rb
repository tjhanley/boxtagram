class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.integer :instagram_id
      t.string :username
      t.string :full_name
      t.string :profile_picture
      t.string :instagram_access_token
      t.string :dropbox_access_token
      t.timestamps
    end
  end
end

