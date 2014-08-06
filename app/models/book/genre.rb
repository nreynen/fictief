class Book::Genre < ActiveRecord::Base
  # belongs_to :category, :class_name => "Bread::Category"
  
  validates_presence_of :name
  
  scope :ordered_by_name, ->{order("name ASC")}
end