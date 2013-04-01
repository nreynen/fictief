class Book::Serie < ActiveRecord::Base
  belongs_to :book_author, :foreign_key => "author_id", :class_name => "Book::Author"
  
  validates_uniqueness_of :name
  
  named_scope :all_sorted_with_author, {
    :order => ["name ASC"], :include => [:book_author]
  }
end