class CreateRights < ActiveRecord::Migration
  def self.up
    create_table :user_rights do |t|
      t.integer :user_id
      t.string :rights_key
      t.timestamps
    end
   
  end

  def self.down
    drop_table :user_rights
  end
end
