class CreateUserSessions < ActiveRecord::Migration
  def self.up
    create_table :user_sessions do |t|
      t.integer :user_id
      t.string :path
      t.string :ip_address
      t.timestamps
    end
   
  end

  def self.down
    drop_table :user_sessions
  end
end
