class AlterItemsAddEnabled < ActiveRecord::Migration
  def self.up
    add_column :items, :enabled, :boolean, :default => true
  end

  def self.down
    remove_column :items, :enabled
  end
end
