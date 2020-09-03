class AddIndexesToUserModel < ActiveRecord::Migration
  def change
    add_index(:users,:instagram_id,:unique => true)
    add_index(:users,:email)
  end
end
