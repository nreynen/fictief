class AlterOrders < ActiveRecord::Migration
  def self.up
    change_column :orders, :paid, :boolean, :default => false
  end

  def self.down
  end
end
