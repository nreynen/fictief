class Book::Author < ActiveRecord::Base
  has_many :book_series, :class_name => "Book::Serie"
  
  validates_uniqueness_of :name
  
  named_scope :all_sorted, {
    :order => ["name ASC"]
  }
end