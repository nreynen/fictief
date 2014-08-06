class AlterItemsAndOrders < ActiveRecord::Migration
  def self.up
    drop_table :items_orders
    add_column :orders, :order, :string
  end

  def self.down
    remove_column :orders, :order, :string
  end
end
