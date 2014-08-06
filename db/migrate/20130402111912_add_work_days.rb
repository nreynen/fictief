class AddWorkDays < ActiveRecord::Migration
  def self.up
    create_table :workdays do |t|
      t.integer :user_id, :null => false
      t.integer :day, :null => false
      t.integer :designation_id, :null => false
      t.string :comment
      t.timestamps
    end
    create_table :designations do |t|
      t.string :name, :null => false
      t.string :colour, :null => false
      t.integer :user_id, :null => false
      t.timestamps
    end
    create_table :sequences do |t|
      t.string :seq, :null => false
      t.integer :user_id, :null => false
      t.timestamps
    end
    add_index :workdays, :user_id
    add_index :workdays, :day
    add_index :designations, :user_id
    add_index :sequences, :user_id
  end

  def self.down
    remove_index :workdays, :user_id
    remove_index :workdays, :day
    remove_index :designations, :user_id
    remove_index :sequences, :user_id
    drop_table :workdays
    drop_table :designations
    drop_table :sequences
  end
end
