class Book::Serie < ActiveRecord::Base
  belongs_to :author, :class_name => "Book::Author"
  
  validates_presence_of :name
  
  scope :ordered_by_name, ->{order("name ASC")}
end