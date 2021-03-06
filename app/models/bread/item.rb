class Bread::Item < ActiveRecord::Base
  belongs_to :category, :class_name => "Bread::Category"
  
  validates_presence_of :category_id
  validates_presence_of :name
  validates_presence_of :price
  
  scope :enabled, ->{where("enabled = ?", true)}
  scope :ordered_by_name, ->{order("name ASC")}
end