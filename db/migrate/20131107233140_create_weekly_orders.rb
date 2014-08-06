class CreateWeeklyOrders < ActiveRecord::Migration
  def self.up
    create_table :weekly_orders do |t|
      t.integer :user_id
      t.string :order
      t.timestamps
    end
  end

  def self.down
    drop_table :weekly_orders
  end
end
