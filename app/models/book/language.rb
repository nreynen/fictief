class Book::Language < ActiveRecord::Base
  
  validates_uniqueness_of :name
  
  named_scope :all_sorted, {
    :order => ["name ASC"]
  }
end