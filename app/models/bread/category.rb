class Bread::Category < ActiveRecord::Base
  
  has_many :items, :class_name => "Bread::Item"
  
  validates_presence_of :name
end