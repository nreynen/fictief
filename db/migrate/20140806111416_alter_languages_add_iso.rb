class AlterLanguagesAddIso < ActiveRecord::Migration
  def up
    add_column :languages, :iso, :string
    
    Language.create({:name => "Nederlands", :iso => "nl"})
    Language.create({:name => "English", :iso => "en"})
    Language.create({:name => "Francais", :iso => "fr"})
    Language.create({:name => "Deutsch", :iso => "de"})
  end
  
  def down
    remove_column :languages, :iso
  end
end
