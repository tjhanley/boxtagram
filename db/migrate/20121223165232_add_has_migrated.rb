class AddHasMigrated < ActiveRecord::Migration
  def change
    add_column :users, :has_migrated, :boolean, :default => false
  end
end
