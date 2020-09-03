class AddEmailToUsers < ActiveRecord::Migration
  def change
    add_column :users, :email, :string, :default => nil
  end
end
