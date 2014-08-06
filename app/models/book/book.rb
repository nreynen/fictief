class Book::Book < ActiveRecord::Base
  belongs_to :author, :class_name => "Book::Author"
  belongs_to :publisher, :class_name => "Book::Publisher"
  belongs_to :language, :class_name => "Language"
  belongs_to :original_language, :class_name => "Language"
  belongs_to :genre, :class_name => "Book::Genre"
  belongs_to :serie, :class_name => "Book::Serie"
  
  validates_presence_of :title
  validates_presence_of :author_id
  validates_presence_of :publisher_id
  
  scope :ordered_by_title, ->{order("title ASC")}
end