class AlterOrdersAddSaturday < ActiveRecord::Migration
  def self.up
    add_column :orders, :saturday_int, :integer
  end

  def self.down
   remove_column :orders, :saturday_int
  end
end
