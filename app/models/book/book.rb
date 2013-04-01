class Book::Book < ActiveRecord::Base
  #belongs_to :serie
  belongs_to :book_author, :foreign_key => "author_id", :class_name => "Book::Author"
  belongs_to :book_publisher, :foreign_key => "publisher_id", :class_name => "Book::Publisher"
  belongs_to :book_language, :foreign_key => "language_id", :class_name => "Book::Language"
  belongs_to :book_original_language, :foreign_key => "original_language_id", :class_name => "Book::Language"
  belongs_to :book_serie, :foreign_key => "serie_id", :class_name => "Book::Serie"
  belongs_to :book_genre, :foreign_key => "genre_id", :class_name => "Book::Genre"
  
  validates_uniqueness_of :title
  validates_uniqueness_of :isbn
  
  named_scope :all_sorted, {
    :order => ["title ASC"], :include => [:book_serie, :book_author, :book_publisher, :book_language, :book_original_language, :book_genre]
    #:order => ["title ASC"], :include => [:book_author, :book_publisher, :book_language]
  }
end