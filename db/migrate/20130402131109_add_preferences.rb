class AddPreferences < ActiveRecord::Migration
  def self.up
    add_column :users, :pref, :text, :limit => 64.kilobytes + 1
    add_column :designations, :wage, :string
  end

  def self.down
    remove_column :users, :pref
    remove_column :designations, :wage
  end
end
