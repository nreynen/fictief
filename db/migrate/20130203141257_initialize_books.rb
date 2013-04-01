class InitializeBooks < ActiveRecord::Migration
  def self.up
    create_table :books do |t|
      t.string :title, :null => false
      t.integer :author_id, :null => false
      t.integer :publisher_id, :null => false
      t.string :isbn, :null => false
      t.string :pages, :null => false
      t.integer :genre_id, :null => false
      t.integer :print_nr, :null => false
      t.integer :print_year, :null => false
      t.integer :language_id, :null => false
      t.integer :original_language_id, :null => false
      t.integer :serie_id
      t.string :comment
      t.timestamps
    end
    create_table :series do |t|
      t.string :name, :null => false
      t.integer :author_id, :null => false
      t.timestamps
    end
    create_table :languages do |t|
      t.string :name, :null => false
      t.timestamps
    end
    create_table :genres do |t|
      t.string :name, :null => false
      t.timestamps
    end
    create_table :publishers do |t|
      t.string :name, :null => false
      t.string :place
      t.timestamps
    end
    create_table :authors do |t|
      t.string :name, :null => false
      t.timestamps
    end
    add_index :books, :author_id
    add_index :books, :publisher_id
    add_index :books, :genre_id
    add_index :books, :language_id
    add_index :books, :original_language_id
    add_index :books, :serie_id
    add_index :series, :author_id
  end

  def self.down
    remove_index :books, :author_id
    remove_index :books, :publisher_id
    remove_index :books, :genre_id
    remove_index :books, :language_id
    remove_index :books, :original_language_id
    remove_index :books, :serie_id
    remove_index :series, :author_id
    drop_table :series
    drop_table :books
    drop_table :languages
    drop_table :genres
    drop_table :publishers
    drop_table :authors
  end
end
