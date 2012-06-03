class CreateUsersOrdersAndItems < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :login
      t.string :password
      t.timestamps
    end
    
    create_table :orders do |t|
      t.integer :user_id
      t.boolean :paid
      t.timestamps
    end
    
    create_table :categories do |t|
      t.string :name
      t.string :description
      t.timestamps
    end
    
    create_table :items do |t|
      t.string :name
      t.decimal :price, :precision => 4, :scale => 2
      t.integer :category_id
      t.timestamps
    end
    
    create_table :items_orders do |t|
      t.integer :item_id
      t.integer :order_id
    end
    
    add_column :orders, :history, :text, :limit => 64.kilobytes + 1
  end

  def self.down
    drop_table :users
    drop_table :orders
    drop_table :items
    drop_table :items_orders
  end
end
