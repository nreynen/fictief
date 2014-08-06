class CreateBreadLogs < ActiveRecord::Migration
  def self.up
    create_table :bread_logs do |t|
      t.integer :cat_id, :null => false
      t.integer :event_date, :null => false
      t.decimal :price, :precision => 4, :scale => 2
      t.timestamps
    end
  end

  def self.down
    drop_table :bread_logs
  end
end
