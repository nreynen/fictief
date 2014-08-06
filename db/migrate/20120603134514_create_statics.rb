class CreateStatics < ActiveRecord::Migration
  def self.up
    create_table :statics do |t|
      t.string :identifier, :null => false
      t.string :text, :null => false
      t.timestamps
    end
   
  end

  def self.down
    drop_table :statics
  end
end
