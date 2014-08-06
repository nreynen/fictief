class AlterBooksAddSerieNr < ActiveRecord::Migration
  def up
    add_column :books, :serie_nr, :integer
  end
  def down
    remove_column :books, :serie_nr
  end
end
