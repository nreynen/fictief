class AlterStaticsChangeText < ActiveRecord::Migration
  def self.up
    change_column :statics, :text, :text, :size => 64.kilobyte + 1
  end

  def self.down
    change_column :statics, :text, :string
  end
end
